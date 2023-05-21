import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/quotationModel.dart';
import 'package:vender/models/quotes.dart';
import 'package:vender/models/tender.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user.dart';

class FirebaseProvider {
  FirebaseFirestore firestoreInst = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<List<Tender>> fetchPreviousTenders() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await firestoreInst.collection('Tender').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tenderDocs = data.docs;
    tenderDocs = tenderDocs
        .where((element) => element["userId"] == loggedInUser!.googleId)
        .toList();
    List<Tender> documentData = tenderDocs.map((e) {
      Map<String, dynamic> doc = e.data();
      doc["tenderId"] = e.id;
      return Tender.fromMap(doc);
    }).toList();

    return documentData;
  }

  Future<bool> addNewQuotation(QuotationModel quotation) async {
    try {
      await firestoreInst.collection('Quotation').add(quotation.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addNewTender(Tender tender) async {
    await sendTender(tender);
    return true;
  }

  Future<String> addImage(XFile? pickedFile) async {
    final ref =
        firebaseStorage.ref().child('images/tender/${pickedFile!.name}');
    UploadTask? uploadTask = ref.putFile(File(pickedFile.path));
    final snapshot = await uploadTask.whenComplete(() => {});
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  Future<List<Users>> getAllUsers() async {
    CollectionReference<Map<String, dynamic>> usersColl =
        firestoreInst.collection('User');
    QuerySnapshot<Map<String, dynamic>> data = await usersColl.get();
    List<Users> allUsersList = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots = data.docs;
    snapshots.removeWhere((element) => element.id == loggedInUser!.googleId);

    for (var doc in snapshots) {
      Map<String, dynamic> data = doc.data();
      data["docId"] = doc.id;
      Users user = Users.fromMap(data);
      allUsersList.add(user);
    }

    return allUsersList;
  }

  Future<List<Users>> getUsersNearby() async {
    List<Users> allUserList = await getAllUsers();
    for (var i = 0; i < allUserList.length; i++) {
      Users user = allUserList[i];
      if (user.coordinates.isNotEmpty) {
        double distanceInMeters = Geolocator.distanceBetween(
          user.coordinates[0],
          user.coordinates[1],
          loggedInUser!.coordinates[0],
          loggedInUser!.coordinates[1],
        );
        if ((distanceInMeters / 1000) > 10) {
          allUserList.removeAt(i);
        }
      }
    }
    return allUserList;
  }

  Future<void> sendTender(Tender tender) async {
    List<Users> allUserList = await getUsersNearby();
    CollectionReference<Map<String, dynamic>> tendersColl =
        firestoreInst.collection('Tender');

    Map<String, dynamic> sendMap = tender.toMap();
    sendMap["userId"] = loggedInUser!.googleId;

    DocumentReference<Map<String, dynamic>> submittedTender =
        await tendersColl.add(sendMap);

    CollectionReference<Map<String, dynamic>> tendUseQuoColl =
        firestoreInst.collection('UserTenderQuotation');

    for (var i = 0; i < allUserList.length; i++) {
      tendUseQuoColl.add(
          {"tenderId": submittedTender.id, "userId": allUserList[i].googleId});
    }
  }

  Future<Map<String,List<Quotes>>> fetchQuotesforTender(String tenderId) async {
    final List<Quotes> acceptedQuotesList = [];
    final List<Quotes> pendingQuotesList = [];
    final List<Quotes> declinedQuotesList = [];

    QuerySnapshot<Map<String, dynamic>> tendUseQuoColl =
        await firestoreInst.collection('UserTenderQuotation').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots =
        tendUseQuoColl.docs;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> listTenderQuotes =
        snapshots.where((element) => element["tenderId"] == tenderId).toList();
    for (var doc in listTenderQuotes) {
      Map<String, dynamic> data = doc.data();
      DocumentSnapshot<Map<String, dynamic>> usersInfo =
          await firestoreInst.collection('User').doc(data["userId"]).get();
      if (usersInfo.data() != null) {
        data["userInfo"] = Users.fromMap(usersInfo.data()!);
        data["tenderQuotId"] = doc.id;
        Quotes quote = Quotes.fromMap(data);
        if (data["accepted"] == null) {
          pendingQuotesList.add(quote);
        }else if(data["accepted"] == true){
          acceptedQuotesList.add(quote);
        }else{
          declinedQuotesList.add(quote);
        }
      }
    }
    return {
      "acceptedQuotesList": acceptedQuotesList,
      "declinedQuotesList": declinedQuotesList,
      "pendingQuotesList": pendingQuotesList,
      };
  }

  Future<bool> awardTender(Quotes quote, bool accepted) async {
    await firestoreInst
        .collection('UserTenderQuotation')
        .doc(quote.tenderQuotId)
        .update({"accepted": accepted});
    await firestoreInst
        .collection('Tender')
        .doc(quote.tenderId)
        .update({"acceptedUserId": quote.userInfo.googleId});
    return true;
  }
}

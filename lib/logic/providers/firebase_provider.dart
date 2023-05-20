import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/quotationModel.dart';
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
      return Tender.fromMap(e.data());
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
    try {
      await sendTender(tender);
      return true;
    } catch (e) {
      return false;
    }
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
    return allUserList.where((user) {
      double distanceInMeters = Geolocator.distanceBetween(
        user.coordinates[0],
        user.coordinates[1],
        loggedInUser!.coordinates[0],
        loggedInUser!.coordinates[1],
      );
      return (distanceInMeters / 1000) <= 10;
    }).toList();
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

  Future<void> recieveTenders() async {
    QuerySnapshot<Map<String, dynamic>> data = await firestoreInst
        .collection('User')
        .doc("ReceivedTenders")
        .collection(loggedInUser!.googleId)
        .get();
    print(data);
  }
}

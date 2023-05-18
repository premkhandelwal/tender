import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/quotationModel.dart';
import 'package:vender/models/tender.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vender/pages/quotation.dart';

import '../../models/user.dart';

class FirebaseProvider {
  FirebaseFirestore firestoreInst = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> fetchPreviousTenders() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await firestoreInst.collection('AddTender').get();
    print('__data ${data}');
    List<Map<String, dynamic>> documentData =
        data.docs.map((e) => e.data()).toList();

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
      await firestoreInst
          .collection('AddTender')
          .doc(loggedInUser!.googleId)
          .set(tender.toMap());
      await sendTender(loggedInUser!.googleId);
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

  Future<void> sendTender(String docId) async {
    List<Users> allUserList = await getUsersNearby();
    for (var i = 0; i < allUserList.length; i++) {
      print(allUserList[i].docId);
      CollectionReference<Map<String, dynamic>> usersColl = firestoreInst
          .collection('User')
          .doc(allUserList[i].docId)
          .collection('ReceivedTenders');
      await usersColl.add({"senderId": docId});
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

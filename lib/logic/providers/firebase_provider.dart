import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vender/models/tender.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider {
  FirebaseFirestore firestoreInst = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> fetchPreviousTenders() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await firestoreInst.collection('AddTender').get();
    List<Map<String, dynamic>> documentData =
        data.docs.map((e) => e.data()).toList();

    return documentData;
  }

  Future<bool> addNewTender(Tender tender) async {
    try {
      await firestoreInst.collection('AddTender').add(tender.toMap());
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
}

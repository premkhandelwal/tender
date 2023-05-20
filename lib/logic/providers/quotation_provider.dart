import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/tender.dart';

class QuotationProvider {
  FirebaseFirestore firestoreInst = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<Map<String, List<Tender>>> getAllQuotations() async {
    List<Tender> currentTenderList = [];
    List<Tender> previousTenderList = [];
    QuerySnapshot<Map<String, dynamic>> recievedTenders =
        await FirebaseFirestore.instance
            .collection('UserTenderQuotation')
            .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> receivedTenderDocs =
        recievedTenders.docs;
    receivedTenderDocs = receivedTenderDocs
        .where((element) => element["userId"] == loggedInUser!.googleId)
        .toList();

    for (var i = 0; i < receivedTenderDocs.length; i++) {
      DocumentSnapshot data = receivedTenderDocs[i];
      DocumentSnapshot<Map<String, dynamic>> tenderInfo =
          await FirebaseFirestore.instance
              .collection('Tender')
              .doc(data["tenderId"])
              .get();
      Map<String, dynamic>? tenderData = tenderInfo.data();
      if (tenderData != null) {
        tenderData['tenderQuotId'] = data.id;
        
        if (data.data().toString().contains('quotationPrice')) {
          tenderData["quotationPrice"] = data["quotationPrice"];
          Tender tender = Tender.fromMap(tenderData);
          previousTenderList.add(tender);
        } else {
          Tender tender = Tender.fromMap(tenderData);
          currentTenderList.add(tender);
        }
      }
    }
    return {"previous": previousTenderList, "current": currentTenderList};
  }

  Future<bool> addQuotation(String userTenderQuotationId, double price) async {
    try {
      await firestoreInst
          .collection("UserTenderQuotation")
          .doc(userTenderQuotationId)
          .update({"quotationPrice": price});
      return true;
    } catch (e) {
      return false;
    }
  }
}

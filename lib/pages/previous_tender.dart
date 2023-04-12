// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sized_box_for_whitespace, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/models/catalog.dart';
import 'package:vender/widgets/item_widget.dart';

class previousTender extends StatefulWidget {
  const previousTender({Key? key}) : super(key: key);

  @override
  State<previousTender> createState() => _previousTenderState();
}

class _previousTenderState extends State<previousTender> {
  String? imgUrl;

  // Future<List> fetchAllTenders() async {
  //   List contactList = [];
  //   CollectionReference tenders =
  //        FirebaseFirestore.instance.collection('').doc('details').get();
  //   contactList = documentSnapshot.data()['contacts'];
  //   return contactList;
  // }
  CollectionReference tenders =
      FirebaseFirestore.instance.collection('AddTender');
  @override
  Widget build(BuildContext context) {
    // final dummyList = List.generate(10, (index) => CatalogModel.items[0]);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('AddTender').snapshots(),
        builder: (BuildContext context, snapshot) {
          // print('snapshotData ${snapshot.data!.docs[0]}');
          return snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height / 1.52,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];

                            return ItemWidget(data: data);
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}

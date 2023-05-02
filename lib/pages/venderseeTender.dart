import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/constants.dart';
import 'package:vender/pages/previous_tender.dart';

import 'Quotation.dart';

class SeeTender extends StatefulWidget {
  const SeeTender({super.key});

  @override
  State<SeeTender> createState() => _SeeTenderState();
}

class _SeeTenderState extends State<SeeTender> {
  late StreamSubscription<DocumentSnapshot> isQuotationfilled;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Tenders',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: const Color(0xff8C33C1),
            ),
          ),
        ),
        previousTender(isVender: true),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Previous Quotation',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: const Color(0xff8C33C1),
            ),
          ),
        ),
        previousQuotations(),
        const SizedBox(
          height: 50,
        ),
      ]),
    ));
  }
}

class previousQuotations extends StatefulWidget {
  @override
  State<previousQuotations> createState() => _previousQuotationsState();
}

class _previousQuotationsState extends State<previousQuotations> {
  String? imgUrl;
  CollectionReference quotations =
      FirebaseFirestore.instance.collection('Quotations');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('QuotationAdded')
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return Card(
                        color: const Color(0xffe4d3e8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 9,
                          child: ListTile(
                            trailing: Text(data['price'] + ' rs'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Quotation(
                                            fromPreviousQuotation: true,
                                            productCategory: "Food",
                                            productQuantity: data['quantity'],
                                            productname: data['productName'],
                                            productimage: data['image'],
                                          )));
                            },
                            leading: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 66,
                                minHeight: 64,
                                maxWidth: 66,
                                maxHeight: 64,
                              ),
                              child: data['image'] == null
                                  ? Container()
                                  : Image.network(
                                      data['image'],
                                    ),
                            ),
                            title: Text(
                              data['productName'],
                              style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff8C33C1),
                              ),
                            ),
                            subtitle: Text(
                              "Qty: ${data['quantity']}\nCategory: ${data['category']}",
                              style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF8C33C1),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        });
  }
}

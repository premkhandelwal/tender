import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/pages/previous_tender.dart';

import 'Quotation.dart';

class SeeTender extends StatelessWidget {
  const SeeTender({super.key});

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
        previousQuotations()
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
        stream: FirebaseFirestore.instance.collection('Quotations').snapshots(),
        builder: (BuildContext context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.52,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
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
                                                  productQuantity:
                                                      data['quantity'],
                                                  productname: data['name'],
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
                                    data['name'],
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
                                      color: Color(0xff8C33C1),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}

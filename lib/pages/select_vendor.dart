// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/routes/routes.dart';

class SelectVendor extends StatelessWidget {
  String? userDocId;

  SelectVendor({this.userDocId});

  @override
  Widget build(BuildContext context) {
    print('docuser $userDocId');
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 25,
                      ),
                      child: Text("Are you a Vendor",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                            fontSize: 24,
                            color: Color(0xff8D33C3),
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 25,
                      ),
                      child: new Text("or Customer?",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 24, color: Color(0xff8D33C3)))),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Divider(
                          color: Color(0xff8D33C3),
                          thickness: 2,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    new Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 7,
                        )),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 1.45,
                            child: ElevatedButton.icon(
                                onPressed: () {},
                                label: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 15,
                                      0.0,
                                      0.0,
                                      0.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Vendor",
                                        style: GoogleFonts.lato(
                                            textStyle:
                                                TextStyle(fontSize: 20))),
                                  ),
                                ),
                                icon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      MediaQuery.of(context).size.width / 15,
                                      0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_right_alt,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff8D33C3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(19),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    new Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 7,
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 1.45,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                print('doc1 ${userDocId}');
                                FirebaseFirestore.instance
                                    .collection('User')
                                    .doc('$userDocId')
                                    .update({'type': 'customer'}).then((value) {
                                  Navigator.pushNamed(
                                      context, MyRoutes.customerDashboardRoute);
                                });
                              },
                              label: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 15,
                                    0.0,
                                    0.0,
                                    0.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Customer",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(fontSize: 20))),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0,
                                    MediaQuery.of(context).size.width / 15, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                    size: 40,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff8D33C3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(19),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

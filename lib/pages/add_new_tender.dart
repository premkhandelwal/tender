// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sized_box_for_whitespace, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/pages/previous_tender.dart';
import 'package:vender/routes/routes.dart';

class addNewTender extends StatefulWidget {
  const addNewTender({Key? key}) : super(key: key);

  @override
  State<addNewTender> createState() => _addNewTenderState();
}

class _addNewTenderState extends State<addNewTender> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    height: (MediaQuery.of(context).size.height / 8),
                    width: (MediaQuery.of(context).size.width),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff8C33C1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15,
                    ),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 8),
                      width: (MediaQuery.of(context).size.width / 1.1),
                      child: Card(
                        color: Color(0xffEAD4EF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.newTenderFormRoute);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.height /
                                              12),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(1.0),
                                                  blurRadius: 6.0,
                                                  offset: Offset(2.0, 2.0))
                                            ],
                                            color: Color(0xff8C33C1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: IconTheme(
                                          data: new IconThemeData(opacity: 100),
                                          child: ImageIcon(
                                            AssetImage("assets/icons/add.png"),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                      ),
                                      child: Text(
                                        "Add New Tender",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontSize: 23,
                                            color: Color(0xff8A33BF),
                                            shadows: [
                                              Shadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 6.0,
                                                color: Colors.grey
                                                    .withOpacity(1.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff8C33C1),
                ),
                height: MediaQuery.of(context).size.height / 18.5,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height / 50,
                    0,
                    MediaQuery.of(context).size.width / 40),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    top: MediaQuery.of(context).size.height / 85,
                  ),
                  child: Text(
                    "Previous Tenders",
                    style: GoogleFonts.lato(
                        letterSpacing: 0.5,
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ),
              ),
              previousTender(),
            ],
          ),
        ),
      ),
    );
  }
}

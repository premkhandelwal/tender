// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_const, avoid_unnecessary_containers
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/routes/routes.dart';

class CustomerDashbord extends StatelessWidget {
  const CustomerDashbord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: Color(0xffFDD6E3),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.addNewTenderRoute);
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height:
                                    MediaQuery.of(context).size.height / 4.0,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          10,
                                      top: MediaQuery.of(context).size.height /
                                          25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                12,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xff8C33C1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: IconTheme(
                                                data: new IconThemeData(
                                                    opacity: 100),
                                                child: ImageIcon(
                                                  AssetImage(
                                                      "assets/icons/tender.png"),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Tender",
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                fontSize: 26,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff8D33C3),
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 6.0,
                                                    color: Colors.grey
                                                        .withOpacity(1.0),
                                                  ),
                                                ],
                                              ))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                12,
                                            color: Color(0xffE4CAEB),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.zero,
                                                  child: Text(
                                                    "Add new Tender",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 11,
                                                            color: Color(
                                                                0xff8D33C3))),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_right_alt,
                                                  size: 20,
                                                  color: Color(0xff8D33C3),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            new Card(
                              color: Color(0xffEBE4FF),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MyRoutes.quotationRoute);
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          12,
                                      top: MediaQuery.of(context).size.height /
                                          25,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  18,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  9,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff8C33C1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: IconTheme(
                                                  data: new IconThemeData(
                                                      opacity: 100),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/quatation.png"),
                                                    size: 43,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Quatation",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff8D33C3),
                                                  letterSpacing: 1,
                                                  shadows: [
                                                    Shadow(
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 6.0,
                                                      color: Colors.grey
                                                          .withOpacity(1.0),
                                                    ),
                                                  ],
                                                ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            new Card(
                              color: Color(0xffD1E9F4),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34.0),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          12,
                                      top: MediaQuery.of(context).size.height /
                                          25,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  18,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  9,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff8C33C1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: IconTheme(
                                                  data: new IconThemeData(
                                                      opacity: 100),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/settings.png"),
                                                    size: 43,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Setting",
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff8D33C3),
                                                  letterSpacing: 1,
                                                  shadows: [
                                                    Shadow(
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 6.0,
                                                      color: Colors.grey
                                                          .withOpacity(1.0),
                                                    ),
                                                  ],
                                                ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              onPressed: () async {
                                Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.loginRoute, (route) => false);
                                await FirebaseAuth.instance.signOut();
                              },
                              label: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 15,
                                    0.0,
                                    0.0,
                                    0.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Logout",
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
                                    Icons.logout,
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
            ),
          ),
        ),
      ),
    );
  }
}

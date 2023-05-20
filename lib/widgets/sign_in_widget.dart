// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/user.dart';
import 'package:vender/pages/login_page.dart';
import 'package:vender/pages/select_vendor.dart';
import 'package:vender/provider/google_sign_in_provider.dart';

import '../routes/routes.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  Future<String> navigateToInitialScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("userData");
    if (userData != null) {
      return 'signOut';
    } else {
      return 'signIn';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                        child: Text(
                          "Welcome To",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 28,
                              color: Color(0xff8D33C3),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 25,
                        ),
                        child: new Text("TENDER",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xff8D33C3)))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Divider(
                          color: Color(0xff8D33C3),
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      new Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                          )),
                          FloatingActionButton.extended(
                            extendedPadding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 10,
                            ),
                            extendedIconLabelSpacing: 10.0,
                            label: Text("Sign In with Google",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 20))),
                            backgroundColor: Color(0xff8D33C3),
                            icon: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 100,
                              ),
                              child: IconTheme(
                                data: new IconThemeData(opacity: 100),
                                child: ImageIcon(
                                  color: Colors.white,
                                  AssetImage("assets/images/google.png"),
                                  size: 24,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              String userDocId = "";

                              final provider =
                                  // ignore: use_build_context_synchronously
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);

                              provider.googleLogin().then((value) async {
                                Map<String, dynamic> userData = {
                                  "name": value.user!.displayName.toString(),
                                  "email": value.user!.email.toString(),
                                  "google_id": value.user!.uid,
                                  'type': '',
                                  'coordinates': [
                                    currentPosition?.latitude,
                                    currentPosition?.longitude
                                  ]
                                };
                                loggedInUser = Users.fromMap(userData);
                                final userRef = FirebaseFirestore.instance
                                    .collection("User")
                                    .doc(value.user!.uid);
                                if ((await userRef.get()).exists) {
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection("User")
                                      .doc(value.user!.uid)
                                      .set(userData, SetOptions(merge: true));
                                }
                                userDocId = value.user!.uid;
                              }).then((value) async {
                                var collection = FirebaseFirestore.instance
                                    .collection('User');
                                collection
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .get()
                                    .then((value) {
                                  var data = value.data();

                                  if (data != null) {
                                    if (data["type"] == 'vendor') {
                                      Navigator.pushReplacementNamed(context,
                                          MyRoutes.venderDashBoardRoute);
                                    } else if (data["type"] == 'customer') {
                                      Navigator.pushReplacementNamed(context,
                                          MyRoutes.customerDashboardRoute);
                                    }
                                    if (data["type"] == '') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectVendor(
                                                    userDocId: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid,
                                                  )));
                                    }
                                    if (data["type"] == 'signIn') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInWidget()));
                                    }
                                  }
                                });
                              });
                            },
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
      ),
    );
  }
}

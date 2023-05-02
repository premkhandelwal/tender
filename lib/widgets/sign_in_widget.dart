// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/constants.dart';
import 'package:vender/pages/select_vendor.dart';
import 'package:vender/provider/google_sign_in_provider.dart';
import 'package:vender/routes/routes.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

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
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              final provider =
                                  // ignore: use_build_context_synchronously
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);

                              provider.googleLogin().then((value) async {
                                Map<String, dynamic> userData = {
                                  "name": value.user!.displayName.toString(),
                                  "email": value.user!.email.toString(),
                                  "google_id": value.credential!.accessToken,
                                  'type': ''
                                };
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
                                userGoogleId = value.credential!.accessToken!;
                                userDocId = value.user!.uid;
                              }).then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectVendor(
                                              userDocId: userDocId,
                                            )));
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

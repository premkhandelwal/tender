import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/pages/venderSeeTender.dart';
import 'package:vender/routes/routes.dart';

class VenderDashBoard extends StatelessWidget {
  const VenderDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                color: const Color(0xffEBE4FF),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SeeTender()));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 12,
                        top: MediaQuery.of(context).size.height / 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 9,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff8C33C1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const IconTheme(
                                    data: IconThemeData(opacity: 100),
                                    child: ImageIcon(
                                      AssetImage("assets/icons/quatation.png"),
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
                                    color: const Color(0xff8D33C3),
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(2.0, 2.0),
                                        blurRadius: 6.0,
                                        color: Colors.grey.withOpacity(1.0),
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 1.45,
              child: ElevatedButton.icon(
                onPressed: () async {
                    final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.clear();
                  await FirebaseAuth.instance.signOut().then((value) async {
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    await googleSignIn.disconnect();
                    await googleSignIn.signOut();

                    
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                        MyRoutes.loginRoute, (route) => false);
                },
                label: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 15, 0.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Logout",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(fontSize: 20))),
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width / 15, 0),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.logout,
                      size: 40,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8D33C3),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/pages/venderseeTender.dart';
import 'package:vender/routes/routes.dart';

class VenderDashBoard extends StatelessWidget {
  const VenderDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: const Color(0xffEBE4FF),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SeeTender()));
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconTheme(
                              data: new IconThemeData(opacity: 100),
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
                              color: Color(0xff8D33C3),
                              letterSpacing: 1,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
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
    );
  }
}

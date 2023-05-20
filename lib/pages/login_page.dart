// // ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, curly_braces_in_flow_control_structures
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:vender/pages/select_vendor.dart';

// import 'package:vender/widgets/sign_in_widget.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             print("snapshot : $snapshot");
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasData) {
//               print("HASDATA");
//               return SelectVendor();
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Something went wrong"));
//             } else {
//               print("SIGNIN");
//               return SignInWidget();
//             }
//           }),
//     );
//   }
// }
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/constants.dart';
import 'package:vender/models/user.dart';
import 'package:vender/pages/select_vendor.dart';
import 'package:vender/widgets/sign_in_widget.dart';

import '../routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _InitialScreenState();
}

Future<String> navigateToInitialScreen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userData = prefs.getString("userData");
  if (userData != null) {
    return 'signOut';
  } else {
    return 'signIn';
  }
  
}

class _InitialScreenState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    navigateToInitialScreen().then((value) {
      print('value $value');
      if (value == 'vendor') {
        Navigator.pushReplacementNamed(context, MyRoutes.venderDashBoardRoute);
      }
      if (value == 'customer') {
        Navigator.pushReplacementNamed(
            context, MyRoutes.customerDashboardRoute);
      }
      if (value == '') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SelectVendor(
                      userDocId: FirebaseAuth.instance.currentUser!.uid,
                    )));
      }
      if (value == 'signIn') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInWidget()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

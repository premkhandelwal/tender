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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vender/widgets/sign_in_widget.dart';

import '../routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<LoginPage> {
  void navigateToInitialScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print('yes ${prefs.getBool('isCustomer')}');

    if (FirebaseAuth.instance.currentUser != null) {
      if (prefs.getBool('isCustomer') ?? false) {
        print('yes 1');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
            context, MyRoutes.customerDashboardRoute);
      } else {
        print('yes 2');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, MyRoutes.venderDashBoardRoute);
      }
    } else {
      print('yes 3');

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInWidget()));
    }
  }

  @override
  void initState() {
    super.initState();

    navigateToInitialScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

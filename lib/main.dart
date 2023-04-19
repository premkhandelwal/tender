import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vender/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vender/pages/Quotation.dart';
import 'package:vender/pages/add_new_tender.dart';
import 'package:vender/pages/customer_dashboard.dart';
import 'package:vender/pages/login_page.dart';
import 'package:vender/pages/new_tender_form.dart';
import 'package:vender/pages/previous_tender.dart';
import 'package:vender/pages/select_vendor.dart';
import 'package:vender/pages/venderDashBoard.dart';
import 'package:vender/provider/google_sign_in_provider.dart';
import 'package:vender/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: MyRoutes.loginRoute,
          routes: {
            MyRoutes.venderDashBoardRoute: (context) => VenderDashBoard(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.selectVendorRoute: (context) => SelectVendor(),
            MyRoutes.customerDashboardRoute: (context) => CustomerDashbord(),
            MyRoutes.addNewTenderRoute: (context) => addNewTender(),
            MyRoutes.previousTenderRoute: (context) => previousTender(),
            MyRoutes.newTenderFormRoute: (context) => NewTenderForm(),
            MyRoutes.quotationRoute: (context) => Quotation(),
          },
        ),
      );
}

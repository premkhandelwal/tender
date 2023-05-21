import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vender/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:vender/logic/bloc/AddTenderBloc/add_tender_bloc.dart';
import 'package:vender/logic/providers/firebase_provider.dart';
import 'package:vender/logic/providers/quotation_provider.dart';
import 'package:vender/pages/Quotation.dart';
import 'package:vender/pages/add_new_tender_page.dart';
import 'package:vender/pages/bids_page.dart';
import 'package:vender/pages/tender_page.dart';
import 'package:vender/pages/customer_dashboard.dart';
import 'package:vender/pages/select_vendor.dart';
import 'package:vender/pages/vender_dashboard.dart';
import 'package:vender/provider/google_sign_in_provider.dart';
import 'package:vender/routes/routes.dart';
import 'package:vender/widgets/sign_in_widget.dart';

import 'logic/bloc/addQuotationBloc/add_quotation_bloc.dart';

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
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AddTenderBloc(firebaseProvider: FirebaseProvider()),
        ),
        BlocProvider(
          create: (context) =>
              AddQuotationBloc(quotationProvider: QuotationProvider()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: MyRoutes.loginRoute,
          routes: {
            MyRoutes.venderDashBoardRoute: (context) => const VenderDashBoard(),
            MyRoutes.loginRoute: (context) => const SignInWidget(),
            MyRoutes.selectVendorRoute: (context) => const SelectVendor(),
            MyRoutes.customerDashboardRoute: (context) =>
                const CustomerDashbord(),
            MyRoutes.tenderRoute: (context) => const TenderPage(),
            MyRoutes.addNewTenderRoute: (context) => const AddNewTenderPage(),
            MyRoutes.quotationRoute: (context) => const Quotation(),
            MyRoutes.bidsRoute: (context) =>  const TenderBigsPage(),
          },
        ),
      ),
    );
  }
}

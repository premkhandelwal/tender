// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sized_box_for_whitespace, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/logic/bloc/AddTenderBloc/add_tender_bloc.dart';
import 'package:vender/pages/venderseeTender.dart';
import 'package:vender/routes/routes.dart';

class TenderPage extends StatefulWidget {
  const TenderPage({Key? key}) : super(key: key);

  @override
  State<TenderPage> createState() => _TenderPageState();
}

class _TenderPageState extends State<TenderPage> {
  late AddTenderBloc addTenderBloc;
  @override
  void initState() {
    super.initState();
    addTenderBloc = BlocProvider.of<AddTenderBloc>(context);
    addTenderBloc.add(FetchPreviousTenders());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                          onTap: () async {
                            await Navigator.pushNamed(
                                context, MyRoutes.addNewTenderRoute);
                            addTenderBloc.add(FetchPreviousTenders());
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
              BlocBuilder<AddTenderBloc, AddTenderState>(
                builder: (context, state) {
                  if (state is FetchTenderInProgressState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is! FetchTenderSuccessState) {
                    return Text("No Previous Tenders found");
                  }
                  return PreviousQuotations(
                    previousTenders: state.tenderData,
                    fromPreviousQuotation: null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

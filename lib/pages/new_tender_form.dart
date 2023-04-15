// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/bloc/AddTenderBloc/ui.dart';
import 'package:vender/routes/routes.dart';
import 'package:vender/widgets/form_widget.dart';

class NewTenderForm extends StatefulWidget {
  const NewTenderForm({super.key});

  @override
  State<NewTenderForm> createState() => _NewTenderFormState();
}

class _NewTenderFormState extends State<NewTenderForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff8C33C1),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, MyRoutes.addNewTenderRoute);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4),
                      child: Text(
                        "Add New Tender",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              formWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

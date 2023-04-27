// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sized_box_for_whitespace, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/logic/bloc/AddTenderBloc/add_tender_bloc.dart';
import 'package:vender/pages/quotation.dart';
import 'package:vender/widgets/item_widget.dart';

class previousTender extends StatefulWidget {
  bool isVender = false;
  previousTender({this.isVender = false});
  @override
  State<previousTender> createState() => _previousTenderState();
}

class _previousTenderState extends State<previousTender> {
  String? imgUrl;
  late AddTenderBloc addTenderBloc;
  @override
  void initState() {
    super.initState();
    addTenderBloc = BlocProvider.of<AddTenderBloc>(context);
    addTenderBloc.add(FetchPreviousTenders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTenderBloc, AddTenderState>(
      builder: (context, state) {
        if (state is FetchTenderInProgressState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FetchTenderSuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.52,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.tenderData.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> data = state.tenderData[index];

                      return ItemWidget(
                        data: data,
                        isVender: widget.isVender,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text(
            "No Previous Tenders found",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: const Color(0xff8C33C1),
            ),
          ),
        );
      },
    );
  }
}

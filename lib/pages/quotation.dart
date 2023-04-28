// ignore_for_file: camel_case_types,prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/models/quotationModel.dart';

import '../constants.dart';
import '../logic/bloc/addQuotationBloc/bloc/add_quotation_bloc.dart';

class Quotation extends StatefulWidget {
  String productname = "";
  int productQuantity = 1;
  String productCategory = "";
  String productimage = "";
  bool? fromPreviousQuotation = false;
  Quotation(
      {this.productCategory = "",
      this.productQuantity = 1,
      this.productname = "",
      this.productimage = "",
      this.fromPreviousQuotation});

  @override
  State<Quotation> createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  String dropdownvalue = 'Furniture';

  final _category = [
    "Furniture",
    "Food",
    "Transport",
    "Personal",
  ];
  int productQuantity = 1;
  late AddQuotationBloc addQuotationBloc;

  @override
  void initState() {
    productQuantity = widget.productQuantity;
    dropdownvalue = widget.productCategory;
    addQuotationBloc = BlocProvider.of<AddQuotationBloc>(context);
    super.initState();
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddQuotationBloc, AddQuotationState>(
      listener: (context, state) {
        // if (state is AddTenderSuccessState) {
        //   const snackBar = SnackBar(
        //     content: Text('Successfully added'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   Navigator.pop(context);
        // }
        // TODO: implement listener
      },
      builder: (context, state) {
        //   if (state is FetchTenderInProgressState ||
        //     state is AddTenderInProgressState) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return SafeArea(
          child: Scaffold(
            body: Container(
              child: Stack(
                children: [
                  Positioned(
                    height: (MediaQuery.of(context).size.height / 3.5),
                    width: (MediaQuery.of(context).size.width),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff8C33C1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          )),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 3.5),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 70,
                                    right:
                                        MediaQuery.of(context).size.width / 30),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
                              child: Text(
                                "Quotation",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.7,
                      width: MediaQuery.of(context).size.width / 0.7,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromARGB(255, 41, 40, 40)
                                    .withOpacity(1.0),
                                blurRadius: 5.0,
                                offset: Offset(2.0, 2.0))
                          ],
                          color: Color(0xffFAF4FB),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // selectImage();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 9.0),
                                      child: SizedBox(
                                        height: 95,
                                        width: 95,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(1.0),
                                                      blurRadius: 2.0,
                                                      offset: Offset(2.0, 2.0))
                                                ],
                                                color: Color(0xff8C33C1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Image.network(
                                                widget.productimage)
                                            // (pickedFile == null)
                                            //     ? Image.asset(
                                            //         "assets/icons/product_img_rect.png")
                                            //     : Image.file(File(pickedFile!.path)),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Product Name",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff8C33C1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 180,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: nameEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: UnderlineInputBorder(),
                                        hintText: widget.productname,
                                        hintStyle: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.75),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 26),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 14, bottom: 15),
                                    child: Text(
                                      "Product Quantity",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff8C33C1),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 35, top: 14, bottom: 15),
                                    child: Text(
                                      "Product Category",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff8C33C1),
                                      )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          productQuantity != 1
                                              ? productQuantity--
                                              : productQuantity;
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          height: 21,
                                          width: 21,
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
                                                    Radius.circular(20))),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Text(
                                          productQuantity.toString(),
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff8C33C1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          productQuantity++;
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          height: 21,
                                          width: 21,
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
                                                    Radius.circular(20))),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: dropdownvalue,
                                          style: GoogleFonts.ubuntu(
                                              textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: Color(0xffBC96C7),
                                          )),
                                          icon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Color(0xff8C33C1),
                                            size: 25,
                                          ),
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                          items: _category.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 42.0),
                                  child: Container(
                                    height: 36,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xff8C33C1)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(1.0),
                                            blurRadius: 2.0,
                                            offset: Offset(2.0, 2.0))
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IconTheme(
                                                data:
                                                    IconThemeData(opacity: 100),
                                                child: ImageIcon(
                                                  AssetImage(
                                                      "assets/icons/rupee.png"),
                                                  color: Color(0xff8932BD),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                width: 90,
                                                child: TextFormField(
                                                  readOnly: widget
                                                          .fromPreviousQuotation!
                                                      ? true
                                                      : false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      priceEditingController,
                                                  decoration: InputDecoration(
                                                    errorBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: "10,000",
                                                    hintStyle:
                                                        GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          color: widget
                                                                  .fromPreviousQuotation!
                                                              ? Colors.black
                                                              : Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0.75),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 5, top: 4),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.fromPreviousQuotation!
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 1.88,
                              left: MediaQuery.of(context).size.width / 3.8,
                              right: MediaQuery.of(context).size.width / 3.8),
                          child: InkWell(
                            onTap: () {
                              if (priceEditingController.text.isNotEmpty) {
                                Map<String, dynamic> addQuotation = {
                                  "name": widget.productname,
                                  "image": widget.productimage,
                                  "category": widget.productCategory,
                                  "quantity": widget.productQuantity,
                                  "price": priceEditingController.text,
                                  "googleId": userGoogleId
                                };
                                print('AddQuotation Body ${userGoogleId}');
                                Map<String, dynamic> addvenderSeentender = {
                                  "productName": widget.productname,
                                  "vendorId": userGoogleId,
                                  "image": widget.productimage,
                                  "category": widget.productCategory,
                                  "quantity": widget.productQuantity,
                                  "price": priceEditingController.text,
                                };
                                FirebaseFirestore.instance
                                    .collection('VendorSeenTender')
                                    .add(addvenderSeentender)
                                    .then((value) {
                                  FirebaseFirestore.instance
                                      .collection('Quotations')
                                      .add(addQuotation)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                });

                                // addQuotationBloc.add(AddQuotation(
                                //     quotation: QuotationModel(
                                //         name: widget.productname,
                                //         imgUrl: widget.productimage,
                                //         category: widget.productCategory,
                                //         quantity: widget.productQuantity,
                                //         price: priceEditingController.text)));
                              } else {
                                const snackBar = SnackBar(
                                  content: Text('Fill the price'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 180,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      blurRadius: 4.0,
                                      offset: Offset(2.0, 2.0))
                                ],
                                color: Color(0xff8C33C1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 22,
                                      right: 22,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconTheme(
                                        data: IconThemeData(opacity: 100),
                                        child: ImageIcon(
                                          AssetImage("assets/icons/submit.png"),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Submit",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

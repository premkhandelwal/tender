// ignore_for_file: camel_case_types,prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vender/logic/bloc/AddTenderBloc/add_tender_bloc.dart';
import 'package:vender/models/tender.dart';
import 'package:vender/routes/routes.dart';

class AddNewTenderPage extends StatefulWidget {
  const AddNewTenderPage({super.key});

  @override
  State<AddNewTenderPage> createState() => _AddNewTenderPageState();
}

class _AddNewTenderPageState extends State<AddNewTenderPage> {
  List<Widget> tenderList = [];
  int productQuantity = 1;
  TextEditingController nameEditingController = TextEditingController();
  late AddTenderBloc addTenderBloc;
  @override
  void initState() {
    addTenderBloc = BlocProvider.of<AddTenderBloc>(context);
    tenderList.add(formBox());
    super.initState();
  }

  addMore() {
    setState(() {
      tenderList.add(formBox());
    });
  }

  String dropdownvalue = 'Furniture';

  final _category = [
    "Furniture",
    "Food",
    "Transport",
    "Personal",
  ];
  String? url;
  XFile? pickedFile;

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    addTenderBloc.add(AddImage(imgFile: pickedFile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTenderBloc, AddTenderState>(
      listener: (context, state) {
        if (state is AddImageSuccessState) {
          url = state.imgUrl;
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 50),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff8C33C1),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context, MyRoutes.addNewTenderRoute);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
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
                      Container(
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: tenderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return formBox();
                            },
                          ),
                        ),
                      ),
                    ]))));
      },
    );
  }

  Widget formBox() {
    return BlocConsumer<AddTenderBloc, AddTenderState>(
      listener: (context, state) {
        if (state is FetchTenderFailureState) {
          const snackBar = SnackBar(
            content: Text('Failed to submit tender'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is AddTenderSuccessState) {
          const snackBar = SnackBar(
            content: Text('Successfully added'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is FetchTenderInProgressState ||
            state is AddTenderInProgressState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            height: 360,
            width: 340,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 15.0),
                      child: Text(
                        "Product Image",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, right: 9.0, bottom: 20.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                selectImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(1.0),
                                          blurRadius: 6.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    color: Color(0xff8C33C1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: IconTheme(
                                  data: IconThemeData(opacity: 100),
                                  child: ImageIcon(
                                    AssetImage("assets/icons/add_img.png"),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 9.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(1.0),
                                          blurRadius: 6.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    color: Color(0xff8C33C1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: (pickedFile == null)
                                    ? Image.asset(
                                        "assets/icons/product_img_rect.png")
                                    : Image.file(File(pickedFile!.path)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     SizedBox(
                    //       height: 60,
                    //       width: 60,
                    //       child: InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               boxShadow: <BoxShadow>[
                    //                 BoxShadow(
                    //                     color: Colors.grey.withOpacity(1.0),
                    //                     blurRadius: 6.0,
                    //                     offset: Offset(2.0, 2.0))
                    //               ],
                    //               color: Color(0xff8C33C1),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(10))),
                    //           child: Image.asset(
                    //               "assets/icons/product_img_rect.png"),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Product Name",
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
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: nameEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(),
                          hintText: "Table",
                          hintStyle: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75),
                          ),
                          contentPadding: EdgeInsets.only(left: 26),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 14, bottom: 12),
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
                              right: 35, top: 14, bottom: 12),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              productQuantity--;
                              addTenderBloc.add(ProductQuantityChange(
                                  prodQty: productQuantity));
                            },
                            child: SizedBox(
                              height: 21,
                              width: 21,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(1.0),
                                          blurRadius: 6.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    color: Color(0xff8C33C1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<AddTenderBloc, AddTenderState>(
                            buildWhen: (prev, curr) {
                              if (curr is ProductQuantityChangdState) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                              );
                            },
                          ),
                          InkWell(
                            onTap: () {
                              productQuantity++;
                              addTenderBloc.add(ProductQuantityChange(
                                  prodQty: productQuantity));
                            },
                            child: SizedBox(
                              height: 21,
                              width: 21,
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(1.0),
                                          blurRadius: 6.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    color: Color(0xff8C33C1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
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
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 42.0),
                      child: Container(
                        height: 42,
                        width: 172,
                        decoration: BoxDecoration(
                          color: Color(0xff8C33C1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: InkWell(
                          onTap: () async {
                           
                            if (url != null) {
                              Map<String, dynamic> addTender = {
                                "name": nameEditingController.text,
                                "imgUrl": url,
                                "category": dropdownvalue,
                                "quantity": productQuantity,
                                
                              };
                              Tender tender = Tender.fromMap(addTender);
                              addTenderBloc.add(AddNewTender(tender: tender));
                              
                              // addTenderBloc.add(AddNewTender(
                              //     tender: Tender(
                              //         name: nameEditingController.text,
                              //         imgUrl: url!,
                              //         category: dropdownvalue,
                              //         quantity: productQuantity)));
                            } else {
                              const snackBar = SnackBar(
                                content:
                                    Text('Please fill all the required fields'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // addMore(); //
                            /* if (url != null && dropdownvalue != null) {
                              Map<String, dynamic> addTender = {
                                "name": nameEditingController.text,
                                "image": url,
                                "category": dropdownvalue,
                                "quantity": productQuantity
                              };
                              // print('addTender Body ${addTender}');
                              FirebaseFirestore.instance
                                  .collection('AddTender')
                                  .add(addTender)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            } */
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 22,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(opacity: 100),
                                      child: ImageIcon(
                                        AssetImage("assets/icons/add_more.png"),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Add More",
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

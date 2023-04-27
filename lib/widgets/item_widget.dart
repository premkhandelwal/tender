import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/pages/Quotation.dart';

class ItemWidget extends StatelessWidget {
  final bool isVender;
  const ItemWidget({
    super.key,
    required this.data,
    required this.isVender,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffe4d3e8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 9,
        child: ListTile(
          onTap: () {
            if (isVender) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Quotation(
                            fromPreviousQuotation: false,
                            productCategory: data['category'],
                            productQuantity: data['quantity'],
                            productname: data['name'],
                            productimage: data['imgUrl'],
                          )));
            }
          },
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 66,
              minHeight: 64,
              maxWidth: 66,
              maxHeight: 64,
            ),
            child: data['imgUrl'] == null
                ? Container()
                : Image.network(
                    data['imgUrl'],
                  ),
          ),
          title: Text(
            data['name'],
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xff8C33C1),
            ),
          ),
          subtitle: Text(
            "Qty: ${data['quantity']}\nCategory: ${data['category']}",
            style: GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:const  Color(0xff8C33C1),
            ),
          ),
        ),
      ),
    );
  }
}

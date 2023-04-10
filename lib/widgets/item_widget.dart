// ignore_for_file: unnecessary_null_comparison, prefer_const_literals_to_create_immutables,prefer_const_constructors, avoid_print, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vender/models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffe4d3e8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 9,
        child: ListTile(
          onTap: () {},
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 66,
              minHeight: 64,
              maxWidth: 66,
              maxHeight: 64,
            ),
            child: Image.asset(
              item.image,
            ),
          ),
          title: Text(
            item.name,
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff8C33C1),
            ),
          ),
          subtitle: Text(
            "Qty: ${item.qty}\nCategory: ${item.category}",
            style: GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff8C33C1),
            ),
          ),
        ),
      ),
    );
  }
}

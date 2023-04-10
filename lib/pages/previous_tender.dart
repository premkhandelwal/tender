// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new, sized_box_for_whitespace, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vender/models/catalog.dart';
import 'package:vender/widgets/item_widget.dart';

class previousTender extends StatelessWidget {
  const previousTender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(10, (index) => CatalogModel.items[0]);
    return Container(
      height: MediaQuery.of(context).size.height / 1.52,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemWidget(
                  item: dummyList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

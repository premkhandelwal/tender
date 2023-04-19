import 'package:flutter/material.dart';
import 'package:vender/pages/previous_tender.dart';

class SeeTender extends StatelessWidget {
  const SeeTender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [previousTender(isVender:true)]));
  }
}

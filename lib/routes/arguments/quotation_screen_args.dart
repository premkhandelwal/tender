import 'package:vender/models/tender.dart';

class QuotationScreenArguments {
  final Tender tenderData;
  final bool? fromPreviousQuotation ;
  QuotationScreenArguments({
    required this.tenderData,
    required this.fromPreviousQuotation,
  });

}
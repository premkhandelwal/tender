part of 'add_quotation_bloc.dart';

@immutable
abstract class AddQuotationEvent {}

class AddQuotation extends AddQuotationEvent {
  final String userTenderQuotationId;
  final double quotedPrice;
  AddQuotation({
    required this.userTenderQuotationId,
    required this.quotedPrice,
  });
}

class FetchTendersQuotation extends AddQuotationEvent {}



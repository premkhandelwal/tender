part of 'add_quotation_bloc.dart';

@immutable
abstract class AddQuotationEvent {}

class AddQuotation extends AddQuotationEvent {
  final QuotationModel quotation;
  AddQuotation({
    required this.quotation,
  });
}

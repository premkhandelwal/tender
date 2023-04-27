part of 'add_quotation_bloc.dart';

@immutable
abstract class AddQuotationState {}

class AddQuotationInitial extends AddQuotationState {}
class AddQuotationInProgressState extends AddQuotationState {}

class AddQuotationSuccessState extends AddQuotationState {}

class AddQuotationFailureState extends AddQuotationState {}
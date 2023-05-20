part of 'add_quotation_bloc.dart';

abstract class AddQuotationState {}

class AddQuotationInitial extends AddQuotationState {}

class AddQuotationInProgressState extends AddQuotationState {}

class AddQuotationSuccessState extends AddQuotationState {}

class AddQuotationFailureState extends AddQuotationState {}

class FetchTendersQuotationInProgressState extends AddQuotationState {}

class FetchTendersQuotationSuccessState extends AddQuotationState {
  final Map<String,List<Tender>> tenderList;
  FetchTendersQuotationSuccessState({
    required this.tenderList,
  });
}

class FetchTendersQuotationFailureState extends AddQuotationState {}

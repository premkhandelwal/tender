part of 'add_tender_bloc.dart';

@immutable
abstract class AddTenderState {}

abstract class AddTenderActionState extends AddTenderState {}

class AddTenderInitial extends AddTenderState {}

class NavigatePop extends AddTenderActionState {}

class ProductQuantityChangdState extends AddTenderActionState {
  final int prodQty;
  ProductQuantityChangdState({
    required this.prodQty,
  });
}

class FetchTenderInProgressState extends AddTenderState {}

class FetchTenderSuccessState extends AddTenderState {
  final List<Tender> tenderData;
  FetchTenderSuccessState({
    required this.tenderData,
  });
}

class FetchTenderFailureState extends AddTenderState {}

class AddTenderInProgressState extends AddTenderState {}

class AddTenderSuccessState extends AddTenderState {}

class AddTenderFailureState extends AddTenderState {}

class AddImageInProgressState extends AddTenderState {}

class AddImageSuccessState extends AddTenderState {
  final String imgUrl;
  AddImageSuccessState({
    required this.imgUrl,
  });
}

class AddImageFailureState extends AddTenderState {}

class FetchQuotesInProgressState extends AddTenderState {}

class FetchQuotesSuccessState extends AddTenderState {
  final Map<String, List<Quotes>> quotesList;
  FetchQuotesSuccessState({
    required this.quotesList,
  });
}

class FetchQuotesFailureState extends AddTenderState {}

class AwardQuoteTenderInProgressState extends AddTenderState {}

class AwardQuoteTenderSuccessState extends AddTenderState {
  final Quotes quote;
  final bool accepted;
  AwardQuoteTenderSuccessState({
    required this.quote,
    required this.accepted,
  });
}

class AwardQuoteTenderFailureState extends AddTenderState {}

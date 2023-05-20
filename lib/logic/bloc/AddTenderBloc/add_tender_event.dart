part of 'add_tender_bloc.dart';

@immutable
abstract class AddTenderEvent {}

class ProductQuantityChange extends AddTenderEvent {
  final int prodQty;
  ProductQuantityChange({
    required this.prodQty,
  });
}

class FetchPreviousTenders extends AddTenderEvent {}

class AddNewTender extends AddTenderEvent {
  final Tender tender;
  AddNewTender({
    required this.tender,
  });
}

class AddImage extends AddTenderEvent {
  final XFile? imgFile;
  AddImage({
    required this.imgFile,
  });
}

class FetchQuotesEvent extends AddTenderEvent {
  final String tenderId;
  FetchQuotesEvent({
    required this.tenderId,
  });
}

class AwardQuoteTenderEvent extends AddTenderEvent {
  final Tender tender;
  AwardQuoteTenderEvent({
    required this.tender,
  });
}

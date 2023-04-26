import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:vender/logic/providers/firebase_provider.dart';
import 'package:vender/models/tender.dart';

part 'add_tender_event.dart';
part 'add_tender_state.dart';

class AddTenderBloc extends Bloc<AddTenderEvent, AddTenderState> {
  final FirebaseProvider firebaseProvider;
  AddTenderBloc({required this.firebaseProvider}) : super(AddTenderInitial()) {
    on<ProductQuantityChange>(productQuantityIncrease);
    on<FetchPreviousTenders>(fetchPreviousTenders);
    on<AddNewTender>(addNewTender);
    on<AddImage>(addImageTender);
  }

  FutureOr<void> productQuantityIncrease(
      ProductQuantityChange event, Emitter<AddTenderState> emit) {
    emit(ProductQuantityChangdState(prodQty: event.prodQty));
  }

  FutureOr<void> fetchPreviousTenders(
      FetchPreviousTenders event, Emitter<AddTenderState> emit) async {
    emit(FetchTenderInProgressState());
    List<Map<String, dynamic>> tenderData =
        await firebaseProvider.fetchPreviousTenders();
    emit(FetchTenderSuccessState(tenderData: tenderData));
  }

  FutureOr<void> addNewTender(
      AddNewTender event, Emitter<AddTenderState> emit) async {
    emit(AddTenderInProgressState());
    bool tenderDataSuccess = await firebaseProvider.addNewTender(event.tender);
    if (tenderDataSuccess) {
      emit(AddTenderSuccessState());
    } else {
      emit(AddTenderFailureState());
    }
  }

  FutureOr<void> addImageTender(
      AddImage event, Emitter<AddTenderState> emit) async {
    emit(AddImageInProgressState());
    String imgUrl = await firebaseProvider.addImage(event.imgFile);
    emit(AddImageSuccessState(imgUrl: imgUrl));
  }
}

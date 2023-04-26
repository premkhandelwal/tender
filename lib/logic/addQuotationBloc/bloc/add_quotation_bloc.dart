import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vender/logic/providers/firebase_provider.dart';
import 'package:vender/models/quotationModel.dart';

part 'add_quotation_event.dart';
part 'add_quotation_state.dart';

class AddQuotationBloc extends Bloc<AddQuotationEvent, AddQuotationState> {
  // final FirebaseProvider firebaseProvider;
  final FirebaseProvider firebaseProvider;
  AddQuotationBloc({required this.firebaseProvider})
      : super(AddQuotationInitial()) {
    on<AddQuotation>(addNewQuotation);
  }

  FutureOr<void> addNewQuotation(
      AddQuotationEvent event, Emitter<AddQuotationState> emit) async {
    // emit(AddTenderInProgressState());
    // bool tenderDataSuccess = await firebaseProvider.addNewQuotation(event.quotation);
    // if (tenderDataSuccess) {
    //   emit(AddTenderSuccessState());
    // } else {
    //   emit(AddTenderFailureState());
    // }
  }
}

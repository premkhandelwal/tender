import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vender/logic/providers/firebase_provider.dart';
import 'package:vender/logic/providers/quotation_provider.dart';
import 'package:vender/models/quotationModel.dart';
import 'package:vender/models/tender.dart';

part 'add_quotation_event.dart';
part 'add_quotation_state.dart';

class AddQuotationBloc extends Bloc<AddQuotationEvent, AddQuotationState> {
  // final FirebaseProvider firebaseProvider;
  final QuotationProvider quotationProvider;
  AddQuotationBloc({required this.quotationProvider})
      : super(AddQuotationInitial()) {
    on<AddQuotation>(addNewQuotation);
    on<FetchTendersQuotation>(fetchTendersQuotation);
  }

  FutureOr<void> addNewQuotation(
      AddQuotation event, Emitter<AddQuotationState> emit) async {
    emit(AddQuotationInProgressState());
    bool quotationDataSuccess = await quotationProvider.addQuotation(
        event.userTenderQuotationId, event.quotedPrice);
    if (quotationDataSuccess) {
      emit(AddQuotationSuccessState());
    } else {
      emit(AddQuotationFailureState());
    }
  }

  FutureOr<void> fetchTendersQuotation(
      FetchTendersQuotation event, Emitter<AddQuotationState> emit) async {
    try {
      emit(FetchTendersQuotationInProgressState());
      Map<String,List<Tender>> quotationDataSuccess =
          await quotationProvider.getAllQuotations();
      emit(FetchTendersQuotationSuccessState(tenderList: quotationDataSuccess));
    } catch (e) {
      emit(FetchTendersQuotationFailureState());
    }
  }
}

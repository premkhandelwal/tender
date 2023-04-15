import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_tender_event.dart';
part 'add_tender_state.dart';

class AddTenderBloc extends Bloc<AddTenderEvent, AddTenderState> {
  AddTenderBloc() : super(AddTenderInitial()) {
    on<ProductQuantityChange>(productQuantityChange);
  }

  FutureOr<void> productQuantityChange(
      ProductQuantityChange event, Emitter<AddTenderState> emit) {
    print('productQuantity');
  }
}

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_test_application/models/payment_method_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethod>(_onLoadPaymentMethod);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
  }

  void _onLoadPaymentMethod(
    LoadPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      PaymentLoaded(),
    );
  }

  void _onSelectPaymentMethod(
    SelectPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      PaymentLoaded(paymentMethod: event.paymentMethod),
    );
  }
}

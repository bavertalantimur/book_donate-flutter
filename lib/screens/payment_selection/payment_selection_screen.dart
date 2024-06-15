import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/payment/bloc/payment_bloc.dart';
import 'package:flutter_test_application/models/models.dart';
import 'package:flutter_test_application/screens/card/card_form_screen.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
import 'package:pay/pay.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  const PaymentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment'),
      bottomNavigationBar: BottomAppBar(),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                        type: ApplePayButtonType.inStore,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                    paymentMethod: PaymentMethod.apple_pay),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(),
                Platform.isAndroid
                    ? RawGooglePayButton(
                        type: GooglePayButtonType.pay,
                        onPressed: () {
                          print("ahmet");
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                    paymentMethod: PaymentMethod.google_pay),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                          SelectPaymentMethod(
                              paymentMethod: PaymentMethod.credit_card),
                        );
                    Navigator.pop(context);
                  },
                  child: Text('Pay With Credit Cart'),
                ),
              ],
            );
          } else {
            return Text('something went wrong');
          }
        },
      ),
    );
  }
}

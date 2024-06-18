import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/payment/bloc/payment_bloc.dart';
import 'package:flutter_test_application/models/models.dart';
import 'package:flutter_test_application/widgets/custom_appbar.dart';
import 'package:flutter_test_application/widgets/custom_navbar.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:pay/pay.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  const PaymentSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Payment'),
      bottomNavigationBar: CustomNavBar(),
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
                if (Platform.isIOS)
                  SizedBox(
                    width: double.infinity,
                    child: RawApplePayButton(
                      type: ApplePayButtonType.inStore,
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                              SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.apple_pay),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                if (Platform.isIOS)
                  SizedBox(height: 20.0), // Spacing between buttons
                if (Platform.isAndroid)
                  SizedBox(
                    width: double.infinity,
                    child: RawGooglePayButton(
                      type: GooglePayButtonType.pay,
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                              SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.google_pay),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                if (Platform.isAndroid)
                  SizedBox(height: 10.0), // Spacing between buttons
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {
                      context.read<PaymentBloc>().add(
                            SelectPaymentMethod(
                                paymentMethod: PaymentMethod.credit_card),
                          );
                      Navigator.pop(context);
                    },
                    fillColor: Color(0xFF8E44AD),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 11.0),
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xFF747775),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Pay With Credit Card',
                      style: GoogleFonts.sora(
                        fontSize: 18, // Font size
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

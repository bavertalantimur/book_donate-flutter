import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CardFormScreen extends StatefulWidget {
  const CardFormScreen({super.key, required this.total});
  final String total;

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  Map<String, dynamic>? paymentIntent;
  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "US",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "Sabir",
          googlePay: gpay,
        ),
      );
      displayPaymentSheet();
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
    } catch (e) {
      print("Failed");
    }
  }

  createPaymentIntent() async {
    print(4444);
    String a = widget.total.toString();
    print(a);
    try {
      print(3333);
      print(widget.total.toString());
      Map<String, dynamic>? body = {
        "amount": "50",
        "currency": "USD",
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51Oz1t9GoVZmaqHdXWomlRgz3HZUdPWV18ZxEEbzQe2Mi6CqDOhznpL5SH6QMw20Kz82k4jDMDWLjRmBW6bgQidg800Vvx7Ezsv",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: ElevatedButton(
              onPressed: () {
                makePayment();
              },
              child: Text("Pay with  Credit Card "))),
    );
  }
}

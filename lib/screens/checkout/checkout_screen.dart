import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_test_application/models/payment_method_model.dart';
import 'package:flutter_test_application/screens/card/card_form_screen.dart';

import '/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              if (Platform.isAndroid) {
                switch (state.paymentMethod) {
                  case PaymentMethod.google_pay:
                    print("alii");
                    return GooglePay(
                      products: state.products!,
                      total: state.total!,
                    );
                  case PaymentMethod.credit_card:
                    print("6886896969");
                    return CardFormScreen(
                      total: state.total!,
                    );
                  default:
                    return GooglePay(
                      products: state.products!,
                      total: state.total!,
                    );
                }
              } else if (Platform.isIOS) {
                switch (state.paymentMethod) {
                  case PaymentMethod.apple_pay:
                    return ApplePay(
                        total: state.total!, products: state.products!);
                  case PaymentMethod.credit_card:
                    return Container();

                  default:
                    return GooglePay(
                        total: state.total!, products: state.products!);
                }
              } else {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment-selection');
                  },
                  child: Text('CHOOSE PAYMENT'),
                );
              }
              /*return Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        context
                            .read<CheckoutBloc>()
                            .add(ConfirmCheckout(checkout: state.checkout));
                        Navigator.pushNamed(context, '/order-confirmation');
                      },
                      child: const Text('OrderNow',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );*/
            } else {
              return Text('Something went  Wrong');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Information',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                  ),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(fullName: value));
                  }, context, 'FullName'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(phone: value));
                  }, context, 'Phone'),
                  Text(
                    'Delivey Information',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                  ),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(address: value));
                  }, context, 'Address'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(city: value));
                  }, context, 'City'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(district: value));
                  }, context, 'District'),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(zipCode: value));
                  }, context, 'Zip'),
                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/payment-selection',
                              );
                            },
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                  ),
                  OrderSummary(),
                ],
              );
            } else {
              return Text('something wrong');
            }
          },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child:
                Text(labelText, style: Theme.of(context).textTheme.bodyText1),
          ),
          Expanded(
              child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ))
        ],
      ),
    );
  }
}

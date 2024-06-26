import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:flutter_test_application/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_test_application/models/payment_method_model.dart';
import 'package:flutter_test_application/screens/card/card_form_screen.dart';

import '/widgets/widgets.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  String address = '';
  String city = '';
  String district = '';
  String zipCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Checkout'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CheckoutLoaded) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Information',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          fullName = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(fullName: value));
                      }, context, 'FullName', 'Please enter your full name'),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          phone = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(phone: value));
                      }, context, 'Phone', 'Please enter your phone number'),
                      const SizedBox(height: 16),
                      Text(
                        'Delivery Information',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          address = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(address: value));
                      }, context, 'Address', 'Please enter your address'),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          city = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(city: value));
                      }, context, 'City', 'Please enter your city'),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          district = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(district: value));
                      }, context, 'District', 'Please enter your district'),
                      const SizedBox(height: 8),
                      _buildTextFormField((value) {
                        setState(() {
                          zipCode = value;
                        });
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(zipCode: value));
                      }, context, 'Zip', 'Please enter your zip code'),
                      const SizedBox(height: 20),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF8E44AD),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/payment-selection',
                            );
                          },
                          child: Text(
                            'SELECT A PAYMENT METHOD',
                            style: GoogleFonts.sora(
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFF8E44AD),
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                'Order Summary',
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              OrderSummary(),
                              const SizedBox(height: 10),
                              if (Platform.isAndroid) ...[
                                if (state.paymentMethod ==
                                    PaymentMethod.google_pay)
                                  GooglePay(
                                    products: state.products!,
                                    total: state.total!,
                                  )
                                else if (state.paymentMethod ==
                                    PaymentMethod.credit_card)
                                  CardFormScreen(total: state.total!)
                                else
                                  GooglePay(
                                    products: state.products!,
                                    total: state.total!,
                                  ),
                              ] else if (Platform.isIOS) ...[
                                if (state.paymentMethod ==
                                    PaymentMethod.apple_pay)
                                  ApplePay(
                                    total: state.total!,
                                    products: state.products!,
                                  )
                                else if (state.paymentMethod ==
                                    PaymentMethod.credit_card)
                                  Container()
                                else
                                  GooglePay(
                                    total: state.total!,
                                    products: state.products!,
                                  ),
                              ] else ...[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/payment-selection');
                                  },
                                  child: Text('CHOOSE PAYMENT'),
                                ),
                              ],
                              const SizedBox(
                                  height: 20), // Space before Order Now button
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFF8E44AD),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    return TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (state is CheckoutLoaded) {
                                            context.read<CheckoutBloc>().add(
                                                ConfirmCheckout(
                                                    checkout: state.checkout));
                                            Navigator.pushNamed(
                                                context, '/order-confirmation');
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Please fill all the fields'),
                                          ));
                                        }
                                      },
                                      child: Text(
                                        'ORDER NOW',
                                        style: GoogleFonts.sora(
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 10), // Adjust bottom space as needed
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
    String errorText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: GoogleFonts.sora(
                fontSize: 14, // Adjust font size as needed
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errorText;
                }
                return null;
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

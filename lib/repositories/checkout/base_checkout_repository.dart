import 'package:flutter_test_application/models/models.dart';

abstract class BaseChekoutRepository {
  Future<void> addCheckout(Checkout checkout);
}

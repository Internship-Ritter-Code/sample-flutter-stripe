import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentHelper {
  late String secretKey;
  PaymentHelper(Map<String, dynamic> data) {
    secretKey = data["secretKey"];
    if (data["payment_method_types[]"] == "card") {
      paymentCard().then((value) => value);
    } else if (data["payment_method_types[]"] == "alipay") {
      otherPayment().then((value) => value);
    }
  }

  Future paymentCard() async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: secretKey,
        merchantDisplayName: "Ada Store",
        style: ThemeMode.dark,
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();
      print("Berhasil");
    } catch (e) {
      log("Error => $e");
    }
  }

  Future otherPayment() async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: secretKey,
        merchantDisplayName: "Ada Store",
        style: ThemeMode.dark,
      ),
    );

    try {
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: secretKey,
        data: PaymentMethodParams.alipay(
          paymentMethodData: PaymentMethodData(),
        ),
      );
      // PaymentMethodParams nya harus di buat satu satu.
      // ini baru ku buat yang alipay
      print("berhasil");
    } catch (e) {
      log("Error => $e");
    }
  }
}

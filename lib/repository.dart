import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class RepositoryLibrary {
  static Future createPayment(Map<String, dynamic> requestBody) async {
    var response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      body: requestBody,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization":
            "Bearer sk_test_51LQ2uyE4QkE6CsLgaGCJmYssRMxCWFh5KV84FMmRSLQTvfsKfFb4hk86dTwLUmKvsmnPSCImlKiialD1M27ljWHk00C8Kc3En5"
      },
    );
    var data = jsonDecode(response.body);
    log(jsonEncode(data));
    return data;
  }
}

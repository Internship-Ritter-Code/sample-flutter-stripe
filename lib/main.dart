import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:example_flutter_stripe/constant.dart';
import 'package:example_flutter_stripe/helper.dart';
import 'package:example_flutter_stripe/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../.env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerNominal = TextEditingController();
  String? payment;

  @override
  void dispose() {
    controllerNominal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: TextButton(
            child: Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () async {
              if (controllerNominal.text.isNotEmpty && payment != null) {
                var data = paymentMethod
                    .where((element) => element['name'] == payment)
                    .first;
                var requestBody = {
                  "amount": controllerNominal.text,
                  "currency": data["currency"],
                  "payment_method_types[]": data["name"],
                };
                // print(requestBody);
                var response =
                    await RepositoryLibrary.createPayment(requestBody);
                requestBody['secretKey'] = response["client_secret"];
                if (response is Map<String, dynamic>) {
                  PaymentHelper(requestBody);
                }
              }
            }),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            color: Colors.white,
            child: TextFormField(
              controller: controllerNominal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                icon: payment != null
                    ? Text(
                        paymentMethod
                            .where((element) => element["name"] == payment)
                            .first["currency"],
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  for (var rows in paymentMethod)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: RadioListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color:
                                rows["status"] == StatusMethodPayment.available
                                    ? payment == rows["name"]
                                        ? Colors.blue
                                        : Colors.black.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.4),
                          ),
                        ),
                        title: Text(
                          rows["name"],
                          style: TextStyle(
                            color:
                                rows["status"] == StatusMethodPayment.available
                                    ? payment == rows["name"]
                                        ? Colors.blue
                                        : Colors.black.withOpacity(0.6)
                                    : Colors.red.withOpacity(0.6),
                          ),
                        ),
                        value: rows["name"],
                        groupValue: payment,
                        onChanged: (e) {
                          if (rows["status"] == StatusMethodPayment.available) {
                            payment = e;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

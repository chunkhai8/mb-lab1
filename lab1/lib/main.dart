import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController amount = TextEditingController();
  String selectMon = "btc", description = "No informations";
  double num = 0.0;
  List<String> ListMon = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 116, 233, 54),
          title: const Text('Bitcoin Exchange App',
              style: TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 69, 65, 65))),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text("Enter the amount of Bitcoin to exchange"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: amount,
                    decoration: InputDecoration(
                        hintText: "Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                  const SizedBox(height: 10),
                  const Text("to"),
                  const SizedBox(height: 10),
                    Container(
                      width: 70,
                      color: Color.fromARGB(181, 131, 231, 77),
                      child: DropdownButton(
                        itemHeight: 50,
                        value: selectMon,
                        onChanged: (newValue) => {
                          setState(() {
                            selectMon = newValue.toString();
                          })
                        },
                        items: ListMon.map((selectMon) {
                          return DropdownMenuItem(
                            child: Text(selectMon),
                            value: selectMon,
                          );
                        }).toList(),
                      ),
                    ),
                  
                  const SizedBox(height: 5),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 131, 231, 77)),
                      onPressed: () {
                        _onConvert();
                      },
                      child: const Text(
                        "Convert",
                        style: TextStyle(fontSize: 20),
                      )),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(description,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 69, 65, 65))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onConvert() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsondata = response.body;
      var parsedata = json.decode(jsondata);
      var value = parsedata['rates'][selectMon]['value'];
      var name = parsedata['rates'][selectMon]['name'];
      setState(() {
        if (amount.text.isEmpty) {
          num = 0.0;
          double result = num * value;

          description =
              " $num Bitcoin = " + result.toStringAsFixed(2) + " $name";
        } else {
          num = double.parse(amount.text);
          double result = num * value;

          description =
              " $num Bitcoin = " + result.toStringAsFixed(2) + " $name";
        }
      });
    }
  }
}

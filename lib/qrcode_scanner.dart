import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'open_form_ver1.dart';

void request(String list) async {
  var local_file = HashMap();
  local_file['同行人數'] = 7;
  local_file['電子郵電'] = 'test@gmail.com';
  local_file['電話'] = '09123456789';
  local_file['姓名'] = 'test';
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = Uri.parse(list);
  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  var data = response.body;
  var index = data.indexOf('data-params');

  var hash = HashMap();
  while(index != -1){
    print("Input:");
    data = data.substring((index + 11));
    var keyword;
    var entry = data;
    for(int i = 0; i < 3; ++i){
      var start = entry.indexOf('[');
      entry = entry.substring((start+1));
      if(i==0){
        entry = entry.substring(entry.indexOf(';')+1);
        keyword = entry.substring(0, entry.indexOf('&'));
        print(keyword);
      }
    }
    var end = entry.indexOf(',');
    entry = entry.substring(0, end);
    print(entry);
    hash[keyword] = entry;
    index = data.indexOf('data-params');
  }
  var finalurl = list+"?";
  hash.forEach((key, value) {
    finalurl += "entry.${value}=${local_file[key]}&";
  });
  print(finalurl);
  runApp(FormView(url:finalurl));
  //var posturi = Uri.parse(final_url);
  //var postresponse = await http.post(posturi);
  //print(postresponse.statusCode);


}

class QrcodeScanner extends StatefulWidget {
  @override
  _QrcodeScannerState createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      request(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('Start QR scan')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
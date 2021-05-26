import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'screens/saveJson.dart';

// Creat hsah map for keywords, many to one hash map
Map<String, String> CreateMap(Map<List<String>, String> map) {
  var newMap = <String, String>{};
  for (var entry in map.entries) {
    var keyList = entry.key;
    for (var key in keyList) {
      newMap[key] = entry.value;
    }
  }
  return newMap;
}

void request(String list) async {

  // Get info in the local file (save in json, saveJson.dart)
  var info = await ContentStorage().readContent(); // Read File

  var localfile = HashMap();
  localfile['同行人數'] = 1;
  localfile['身分證字號'] = info.id;
  localfile['電子郵件'] = info.email;
  localfile['電話'] = info.phone;
  localfile['姓名'] = info.name;
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  
  // ************ Get the Full redirect url ************ 
  // Await the http get response, then decode the json-formatted response.
  final client = http.Client();
  final request = new http.Request('GET', Uri.parse(list))
  ..followRedirects = false;
  final responseFull = await client.send(request);
  String fullUrlString = responseFull.headers['location'].toString();
  
  var url;
  var finalurl;
  // print(fullUrlString);
  // long url
  if (["",null, false, "null"].contains(fullUrlString)){
    // print("long url");
    finalurl = list;
    url = Uri.parse(list);
  }
  // Short url, if it is not short url, the fullUrlString will be null
  else{
    // print("redirect url");
    finalurl = fullUrlString;
    url = Uri.parse(fullUrlString);
  }
  // ************ Get the Full redirect url ************ 
   
  var response = await http.get(url);
  var data = response.body;
  var index = data.indexOf('data-params');

  // The keyword hash map to check if the title in the form contain keyword
  var keywordMap = CreateMap({
    ['姓名', '貴姓', '大名','稱呼','聯絡人']:"姓名",
    ['電話', '手機']:"電話",
    ['電子郵件', '郵件', '信箱','mail','E-mail']:"電子郵件",
    ['身分證字號']:"身分證字號",
    ['同行人數', '人數', '陪同']:"同行人數"
  });


  var hash = HashMap();
  while(index != -1){
    print("Input:");
    data = data.substring((index + 11));
    var keyword;
    var title;
    var entry = data;
    for(int i = 0; i < 3; ++i){
      var start = entry.indexOf('[');
      entry = entry.substring((start+1));
      if(i==0){
        entry = entry.substring(entry.indexOf(';')+1);
        title = entry.substring(0, entry.indexOf('&'));

        // Go through the keywordMap, to find if title contain key
        keywordMap.forEach((key, value) {
          if (title.contains(key)){
            keyword = keywordMap[key];
            // print(keywordMap[key]);
          }
        });

        print(keyword);
      }
    }
    var end = entry.indexOf(',');
    entry = entry.substring(0, end);
    print(entry);
    hash[keyword] = entry;
    index = data.indexOf('data-params');
  }
  
  // check url "?"
  if (finalurl.contains("?"))
    finalurl = finalurl+"&";
  else
    finalurl = finalurl+"?";
  
  hash.forEach((key, value) {
    finalurl += "entry.$value=${localfile[key]}&";
  });
  print(finalurl);
  runApp(_launchURL(finalurl));
  //var posturi = Uri.parse(final_url);
  //var postresponse = await http.post(posturi);
  //print(postresponse.statusCode);
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

}

_launchURL(url) async {
  // const url =
      // "https://docs.google.com/forms/d/e/1FAIpQLScw30Eq9oRONqVv_tLolp0BubC8LfIMllCgffOoLbD7MJpuBg/viewform?emailAddress=123@gmail.com&entry.770857854=%E5%8A%89%E8%B1%AA%E5%B2%A1&entry.1613430569=1";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}

/** 
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
**/
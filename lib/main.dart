import 'package:flutter/material.dart';
import 'qrcode_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Covid Autofill'),
      ),
      body: HomePage(),
    ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('QRcode Scanner'),
        onPressed: () => runApp(QrcodeScanner()),
    ));
  }

}
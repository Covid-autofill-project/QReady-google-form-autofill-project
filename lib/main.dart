import 'package:flutter/material.dart';
import 'qrcode_scanner.dart';
import 'http_data.dart';
import 'screenInput.dart';

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
        ),
        routes: <String, WidgetBuilder>{
          "/ScreenInput": (BuildContext context) => new ScreenInput()
        });
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController myController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      ElevatedButton(
        child: Text('QEcode Scanner'),
        onPressed: request,
      ),
      // entry point of Screen Input Try
      ElevatedButton(
          child: Text('Change to Screen Input'),
          onPressed: () {
            Navigator.of(context).pushNamed("/ScreenInput");
          })
    ]));
  }
}

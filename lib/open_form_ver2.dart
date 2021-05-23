import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

// open the form in outside app (e.g. chrome, safari...)

class FormView extends StatefulWidget {
  FormView ({Key? key, required this.url}): super(key:key);

  final url;

  @override
  _FormView createState() => _FormView();
}

class _FormView extends State<FormView> {
  final GlobalKey webViewKey = GlobalKey();
  // String url =
      // "https://docs.google.com/forms/d/e/1FAIpQLScw30Eq9oRONqVv_tLolp0BubC8LfIMllCgffOoLbD7MJpuBg/viewform?emailAddress=123@gmail.com&entry.770857854=%E5%8A%89%E8%B1%AA%E5%B2%A1&entry.1613430569=1";

  late PullToRefreshController pullToRefreshController;
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _launchURL(widget.url), 
            child: Text('go')
          ),
        )
    );
  }
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

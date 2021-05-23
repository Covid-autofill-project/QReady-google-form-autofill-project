import 'dart:io';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildSearchBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 100, 50.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40.0),
            buildTitle('Covid</>Autofill', context),
            SizedBox(height: 10.0),
            buildContent('這是由台大與清大學生開發的 App', context),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  buildTitle(String restaurant, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$restaurant",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  buildContent(String category, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$category",
          style: TextStyle(
            fontSize: 15.0,
            // fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

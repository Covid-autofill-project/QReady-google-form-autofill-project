
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildSearchBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 100, 5.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40.0),
            buildTitle('Covid</>Autofill', context),
            SizedBox(height: 10.0),
            buildContent('這是由台大與清大學生開發的 App', context),
            SizedBox(height: 10.0),
            buildContent('步驟一：進入右下角個人頁面，填寫完整資訊', context),
            SizedBox(height: 5.0),
            buildContent('步驟二：按下方"+"鍵，掃描QR code 表單', context),
            SizedBox(height: 5.0),
            buildContent('步驟三：打開已自動填寫的網頁表單，完成並送出', context),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }

  buildTitle(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$title",
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
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

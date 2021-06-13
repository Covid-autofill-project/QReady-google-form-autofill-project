
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/const.dart';
import './tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
      // appBar: buildSearchBar(context),
      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(30.0, 100, 5.0, 0),
      //   child: ListView(
      //     children: <Widget>[
      //       SizedBox(height: 40.0),
      //       buildTitle('Covid</>Autofill', context),
      //       SizedBox(height: 10.0),
      //       buildContent('這是由台大與清大學生開發的 App', context),
      //       SizedBox(height: 10.0),
      //       buildContent('步驟一：進入右下角個人頁面，填寫完整資訊', context),
      //       SizedBox(height: 5.0),
      //       buildContent('步驟二：按下方"+"鍵，掃描QR code 表單', context),
      //       SizedBox(height: 5.0),
      //       buildContent('步驟三：打開已自動填寫的網頁表單，完成並送出', context),
      //       SizedBox(height: 5.0),
      //     ],
      //   ),
      // ),
    // ); 
    TextStyle titleStyle = new TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w900,
      // color: Constants.darkAccent,
      color: Colors.black,
    );
    TextStyle contentStyle = new TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    );
    TextStyle btnTextStyle = new TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w900,
      color: Constants.lightPrimary,
    );
    ButtonStyle btnStyle = ElevatedButton.styleFrom(
      // primary: Colors.purple,
      primary: Constants.lightAccent,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      shape: (
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
      ),
    );

    return  Container(
      decoration: BoxDecoration(color: Constants.ratingBG),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: Row()),
          Expanded(flex: 3, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Image.asset('assets/icon/logo_tran_white.png')])),
          Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(Constants.appName, style: titleStyle)])),
          Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("QR code 掃描、自動填寫表單", style: contentStyle)])),
          Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[ElevatedButton(onPressed: () => {handleOpenTutorialBtn()} , style: btnStyle ,child: Text("Tutorial", style: btnTextStyle,))])),
          Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
            IconButton( icon: SvgPicture.asset('assets/icon/facebook.svg',height: 25.0,width: 25.0,allowDrawingOutsideViewBox: true,), onPressed: () =>  _launchURL("https://www.facebook.com/106618268300742/")),
            IconButton( icon: SvgPicture.asset('assets/icon/help_black_24dp.svg',height: 25.0,width: 25.0,allowDrawingOutsideViewBox: true,), onPressed: () =>  _launchURL("https://docs.google.com/forms/d/e/1FAIpQLSeNQ4uKQnz3TstBErG86nJPwmMURUE6A87v16srENOqAeQtAQ/viewform?usp=sf_link")),
          ])),
          Expanded(flex: 1, child: Row()),
        ],
    ));
  }

  _launchURL(url) async {
    url = Uri.encodeFull(url); // url to url encode.
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

  handleOpenTutorialBtn() {
    runApp(TutorialScreen());
  }

  buildTitle() {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: <Widget>[
    //     Text(
    //       "$title",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 30.0,
    //         fontWeight: FontWeight.w900,
    //       ),
    //     ),
    //   ],
    // );
  
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

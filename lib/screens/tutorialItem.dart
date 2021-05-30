import 'package:flutter/material.dart';
import '../util/const.dart';
import '../main.dart';

List<String> descriptions = [
  "點擊右下方的按鈕來輸入資料",
  "點擊下方的相機來掃描 QR code",
  "確認資料並送出",
  "了解更多：）"
];

List<String> otherInfos = [
  "我們不會將你的所有資料上傳到雲端",
  "",
  "",
  "這是由台大與清大學生開發的 App",
];

List<AssetImage> images = [
  AssetImage('assets/tutorials/step1.png'),
  AssetImage('assets/tutorials/step2.png'),
  AssetImage('assets/tutorials/step3.png'),
  AssetImage('assets/tutorials/step4.png'),
];

class TutorialItem extends StatelessWidget {
  final index;
  const TutorialItem({Key? key, required this.index}): super(key:key);

  @override 
  Widget build(BuildContext context) {
    TextStyle titleTextStyle = TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900, color: Constants.lightPrimary);
    TextStyle desTextSytle   = TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Constants.lightPrimary);
    TextStyle infoTextStyle  = TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Constants.lightPrimary);
    ButtonStyle btnStyle = ElevatedButton.styleFrom(
      primary: Constants.ratingBG,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    Widget title        = Text("Step ${this.index}",       style: titleTextStyle,);
    Widget description  = Text(descriptions[this.index-1], style: desTextSytle);
    Widget info         = Text(otherInfos[this.index-1],   style: infoTextStyle);
    Image img           = Image(image: images[this.index-1]);

    Widget startBtn     = ElevatedButton(onPressed: () => runApp(MyApp()), child: Text("開始使用"), style: btnStyle);

    Widget tutorialPage = Container(
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(flex: 1, child: Row()),
          Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center,    children: [title],)),
          Expanded(flex: 4, child: Row(mainAxisAlignment: MainAxisAlignment.center,    children: [img],)),
          Expanded(flex: 1, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [description, info, if (index==4)  startBtn],)),
        ],
    ));


    return tutorialPage;
  } 
}
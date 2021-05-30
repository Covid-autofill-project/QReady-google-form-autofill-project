import 'package:flutter/material.dart';
import '../util/const.dart';
import './tutorialItem.dart';
import '../main.dart';
import './main_screen.dart';
class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  PageController? _pageController;
  int _page = 0;


  @override 
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    Widget leaveBtn = Positioned(
      top: 40.0,
      left:30.0,
      child: IconButton(
        onPressed: () => runApp(MyApp()), 
        icon: Icon(
          Icons.cancel_outlined,
          size: 40.0,
          color: Colors.white)
    ));

    Widget tutorialPageView = PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      scrollDirection: Axis.horizontal,
      children: [
        TutorialItem(index:1),
        TutorialItem(index:2),
        TutorialItem(index:3),
        TutorialItem(index:4),
      ],
    );

    return extendToMaterialApp(
      Scaffold(
          body:Stack(
            children: [
              tutorialPageView,
              leaveBtn,
            ],
          )
        )
    );
  }

  // since runApp() will detach the previous widget (the materialApp() will be dettached, too)
  // We have to re-import it again after calling runApp()
  Widget extendToMaterialApp(Widget w) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: w,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
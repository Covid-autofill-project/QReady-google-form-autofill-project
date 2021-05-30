import 'package:flutter/material.dart';
import 'home.dart';
import './screenInput.dart';
import '../qrcode_scanner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  int _page = 0;

  List icons = [
    Icons.home,
    Icons.camera,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Center(
            child: Home(),
          ),
          // ElevatedButton(   // this button is never used since the qr code scanner is triggered by floating button # ken
          //   onPressed: () => scanQR(),
          //   child: Text('Start QR scan')
          // ),
          Center(
            child: ScreenInput(pc: _pageController),
          )
        ],
      ),
      bottomNavigationBar: extendedButtonNavigationBar(),
      floatingActionButton: extendedFloatingActionButton(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling, // this property is never used since the location of floating button never changes # ken
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
    );
  }
  
  Widget extendedButtonNavigationBar() { // hide the navigation bar in some pages
    return AnimatedOpacity(
        opacity: (_page == 1) ? 0.0 : 1.0, 
        duration: Duration(microseconds: 1000),
        curve: Curves.ease,
        child:BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildTabIcon(0),
              buildTabIcon(2),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
    );
  }
  Widget extendedFloatingActionButton() { // Hide the floating button in some pages
      return Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: (_page!= 1)? true : false,
        child: Container(
          child: SizedBox(
              height: 100,
              width:  100,
              child: FloatingActionButton(
                isExtended: true,
                elevation: 10.0,
                child: Icon(Icons.camera_alt_outlined, size: 50,),
                onPressed: () => scanQR(),
          )
          )
          
      ));
  }

  void navigationTapped(int page) {  // Is there anyone  call this function? the function seems useless? # ken
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    print("Current page: $page.......");
    setState(() {
      this._page = page;
    });
  }

  buildTabIcon(int index) {
    if(index != 1){ 
      return IconButton(
        icon: Icon(
          icons[index],
          size: 24.0,
        ),
        color: _page == index
            ? Theme.of(context).accentColor
            : Theme.of(context).textTheme.caption?.color,
        onPressed: () => _pageController.jumpToPage(index),

      );
    }
    else{
      return IconButton(
        icon: Icon(
          icons[index],
          size: 24.0,
        ),
        color: _page == index
            ? Theme.of(context).accentColor
            : Theme.of(context).textTheme.caption?.color,
        onPressed: () => scanQR(),

      );
    }
  }
  
}

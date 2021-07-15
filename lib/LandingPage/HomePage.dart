import 'package:crypt/LandingPage/FirstPage.dart';
import 'package:crypt/Statistic/RedirectToAfiliat.dart';
import 'package:crypt/Statistic/StatisTic.dart';
import 'package:share/share.dart';
import 'package:crypt/components/Mydrawor.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobInterstitial interstitialAd;
  bool _switch = true;
  bool _switcher = false;

  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  int _currentPage = 0;
  final _pageController = PageController();
  ThemeData _dark = ThemeData(
      primaryColor: Color(0xFF223C53),
      backgroundColor: Color(0xFF23415b),
      scaffoldBackgroundColor: Color(0xFF223C53),
      accentColor: Colors.white);
  ThemeData _light = ThemeData(
      scaffoldBackgroundColor: Color(0xFFe3e8f3),
      backgroundColor: Color(0xFFe9ecf3),
      bottomAppBarColor: Color(0xFFFFFFFF),
      primaryColor: Color(0xFFe3e8f3),
      accentColor: Colors.black);
  int selectesdindex = 0;
  List<Widget> widgetpages = [
    FirstPage(),
    StatisTic(),
    InkWell(
      child: Text("click", style: TextStyle(color: Colors.green)),
      onTap: () {
        Share.share('https://facebook.com');
      },
    )
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _switch ? _dark : _light,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            FirstPage(),
            StatisTic(),
            RedirectToAfiliat(),
          ],
          onPageChanged: (index) {
            // Use a better state management solution
            // setState is used for simplicity
            setState(() => _currentPage = index);
          },
        ),

        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: BottomBar(
            itemPadding: EdgeInsets.all(20),
            selectedIndex: _currentPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              setState(() => _currentPage = index);
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.bar_chart_sharp),
                title: Text(''),
                activeColor: Colors.blue,
              ),
              BottomBarItem(
                icon: Icon(
                  Icons.attach_money_outlined,
                  size: 30,
                ),
                title: Text(''),
                activeColor: Colors.blue,
                darkActiveColor: Colors.red.shade400, // Optional
              ),
              BottomBarItem(
                icon: Icon(Icons.account_balance_wallet),
                title: Text(''),
                activeColor: Colors.blue,
                darkActiveColor: Colors.greenAccent.shade400, // Optional
              ),
            ],
          ),
        ),
        // backgroundColor: Color(0xFF223C53),
        appBar: AppBar(
            toolbarHeight: 50,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Block",
                ),
                Text(
                  "BIT",
                  style: TextStyle(
                      color: Color(0xFFeeb609), fontSize: 14, height: 2),
                ),
              ],
            ),
            actions: [
              Switch(
                  activeThumbImage: AssetImage("images/dark.png"),
                  inactiveThumbImage: AssetImage("images/light.png"),
                  value: _switch,
                  onChanged: (_newvalue) {
                    setState(() {
                      _switcher != false
                          ? _switcher = _newvalue
                          : _switch = _newvalue;
                    });
                  })
            ],
            leading: Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.clear_all),
                  onPressed: () => Scaffold.of(context).openDrawer());
            })),

        drawer: Mydrawor(),
      ),
    );
  }
}

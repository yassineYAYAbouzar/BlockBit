import 'package:crypt/LandingPage/LoadData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  AdmobBannerSize bannerSize;
  AdmobReward rewardAd;
  @override
  void initState() {
    super.initState();
    rewardAd = AdmobReward(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );

    rewardAd.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 10),
          child: Center(
              widthFactor: 2,
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: Color(0XFFeeb609),
                radius: 40.0,
                backgroundImage: AssetImage("images/ico.png"),
              )),
        ),
        Center(
          child: Text(
            "Welcome To BlockBit",
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 20),
          ),
        ),
        Center(
            child: Text(
          "Welcome to BlockBit, we are here to provide you with the first digital currency",
          style: TextStyle(color: Colors.grey, fontSize: 10, height: 1.5),
        )),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 130),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: MaterialButton(
            onPressed: () {
              rewardAd.show();
              openUrl(
                  "https://app.studentcoin.org/buy?utm_source=Coinranking&utm_campaign=inCoins");
            },
            height: 45,
            child: Text(
              "To Coin ",
              style: TextStyle(color: Colors.white),
            ),
            color: Color(0xFFeeb609),
            minWidth: double.infinity,
          ),
        ),
        AdmobBanner(
          adUnitId: AdsManager.bannerAdUnitId,
          adSize: AdmobBannerSize.BANNER,
        ),
        Container(
          padding: EdgeInsets.all(5),
          // width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: LoadData(),
        )
      ],
    );
  }
}

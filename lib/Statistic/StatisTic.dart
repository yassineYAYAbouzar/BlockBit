import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class StatisTic extends StatefulWidget {
  @override
  _StatisTicState createState() => _StatisTicState();
}

class _StatisTicState extends State<StatisTic> {
  final _nativeAdController = NativeAdmobController();
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
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Cryptocurrency market statistics',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 29),
          ),
        ),
        ListTile(
          title: Text("Crypto market cap ",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
          leading: Icon(Icons.invert_colors, color: Colors.grey),
          trailing: Text(
            '£ 1.51 trillion',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          title: Text("24h volume ",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
          leading: Icon(Icons.stacked_line_chart_sharp, color: Colors.grey),
          trailing: Text(
            '£ 11,429',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          title: Text("Cryptocurrency ",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
          leading: Icon(Icons.stacked_line_chart_sharp, color: Colors.grey),
          trailing: Text(
            '11,429',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          title: Text("All crypto exchanges",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
          leading: Icon(Icons.domain_sharp, color: Colors.grey),
          trailing: Text(
            '201',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        ListTile(
          title: Text("All crypto markets",
              style: TextStyle(
                color: Theme.of(context).accentColor,
              )),
          leading: Icon(Icons.stacked_line_chart_sharp, color: Colors.grey),
          trailing: Text(
            '73,806',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        Container(
          color: Colors.white,
          height: 100,
          child: NativeAdmob(
            adUnitID: AdsManager.nativeAdUnitId,
            numberAds: 3,
            controller: _nativeAdController,
            type: NativeAdmobType.full,
          ),
        ),
        MaterialButton(
          onPressed: () {
            rewardAd.show();
          },
          child: Text("Get Free Coins"),
          color: Colors.yellow,
        )
      ],
    );
  }
}

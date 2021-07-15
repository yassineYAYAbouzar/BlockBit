import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class DiatelsCoin extends StatefulWidget {
  final price;
  final uuid;
  final iconUrl;
  final changed;
  final marketCap;
  final listedAt;
  final sparkline;
  final coinrankingUrl;
  final hV24olume;
  final btcPrice;
  final namen;
  DiatelsCoin(
      {this.price,
      this.iconUrl,
      this.uuid,
      this.changed,
      this.marketCap,
      this.listedAt,
      this.sparkline,
      this.coinrankingUrl,
      this.hV24olume,
      this.namen,
      this.btcPrice});
  @override
  _DiatelsCoinState createState() => _DiatelsCoinState();
}

class _DiatelsCoinState extends State<DiatelsCoin> {
  final _nativeAdController = NativeAdmobController();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  String what_is = '';
  String the_goal = '';
  String who_built = '';
  Future getData() async {
    var url = "https://yassinebouzar.000webhostapp.com/about.php";
    var response = await http.post(url, body: {"id": widget.uuid});
    var responsebody = jsonDecode(response.body);
    setState(() {
      what_is = responsebody['What_is'];
      the_goal = responsebody['The_goal'];
      who_built = responsebody['Who_built'];
    });
    print(responsebody);
    return responsebody;
  }

  @override
  void initState() {
    getData();
    super.initState();
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    _nativeAdController.dispose();
    super.dispose();
  }

  openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namen),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AdmobBanner(
                    adUnitId: AdsManager.bannerAdUnitId,
                    adSize: AdmobBannerSize.BANNER,
                  ),
                ),
                Text(
                  "\$ " + widget.price,
                  style: TextStyle(
                      fontSize: 45, color: Theme.of(context).accentColor),
                ),
                Row(
                  children: [
                    Text(
                      "\$  " + widget.changed.toStringAsFixed(2),
                      style: TextStyle(
                          color:
                              widget.changed > 0 ? Colors.green : Colors.red),
                    ),
                    widget.changed > 0
                        ? Icon(
                            Icons.trending_up,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.trending_down,
                            color: Colors.red,
                          )
                  ],
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        widget.changed > 0
                            ? Icon(
                                Icons.trending_up_sharp,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.trending_down_sharp,
                                color: Colors.red,
                              ),
                        Text(
                          "\$  " +
                              num.parse(widget.sparkline[0]).toStringAsFixed(2),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  widget.changed > 0
                      ? Image.asset(
                          "images/polyG.png",
                        )
                      : Image.asset(
                          "images/polyR.png",
                        ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        widget.changed > 0
                            ? Icon(
                                Icons.trending_up_sharp,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.trending_down_sharp,
                                color: Colors.red,
                              ),
                        Text(
                          "\$  " +
                              num.parse(widget.sparkline[1]).toStringAsFixed(2),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  what_is != ''
                      ? Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 410,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 50),
                              child: ListView(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "About ${widget.namen}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 27,
                                  ),
                                  Text(
                                    "What is ${widget.namen}",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 15),
                                  ),
                                  Divider(
                                    endIndent: 260,
                                    thickness: 2,
                                    color: Color(0xFFeeb609),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(what_is,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "The goal ${widget.namen}",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 15),
                                  ),
                                  Divider(
                                    endIndent: 260,
                                    thickness: 2,
                                    color: Color(0xFFeeb609),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(the_goal,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  Text(
                                    "Who_built ${widget.namen}",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 15),
                                  ),
                                  Divider(
                                    endIndent: 260,
                                    thickness: 2,
                                    color: Color(0xFFeeb609),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(who_built,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.cyanAccent,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFFeeb609)),
                          ),
                        )
                ],
              )),
        ],
      ),
    );
  }
}

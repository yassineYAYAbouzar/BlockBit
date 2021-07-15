import 'package:url_launcher/url_launcher.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:share/share.dart';

class RedirectToAfiliat extends StatefulWidget {
  openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  _RedirectToAfiliatState createState() => _RedirectToAfiliatState();
}

class _RedirectToAfiliatState extends State<RedirectToAfiliat> {
  int number = 0;
  int count = 0;
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

    _getCounter();
    _setoneCounter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addOne(one) {
    setState(() {
      number += one;
    });
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getInt('counter');
    });
  }

  _setoneCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() async {
      await prefs.setInt('counter', 1);
    });
  }

  _setCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() async {
      await prefs.setInt('counter', number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
              child: AdmobBanner(
            adUnitId: AdsManager.bannerAdUnitId,
            adSize: AdmobBannerSize.BANNER,
          )),
          // End Careousel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Mony \$ " + number.toString(),
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).accentColor),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Opps!',
                    desc: 'You need To Have 1000 Coins To Convert',
                  )..show();
                },
                child: Text("convert To Bitcon"),
                color: Colors.yellow,
              )
            ],
          ),
          Divider(),
          // End Cat

          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Esy Mony",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Theme.of(context).accentColor),
            ),
            decoration: BoxDecoration(
                // color: Color(0XFFF7F7F7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(10),
            height: 400,
            decoration: BoxDecoration(
                // color: Color(0XFFF7F7F7),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
              children: <Widget>[
                Container(
                  height: 70,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () async {
                      if (await rewardAd.isLoaded) {
                        addOne(2);
                        _setCounter();
                      }
                      rewardAd.show();
                    },
                    child: Image.asset(
                        "images/ai-c9094e47-18aa-4f56-8f8a-ab7e6c633de.png"),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () async {
                      if (await rewardAd.isLoaded) {
                        addOne(2);
                        rewardAd.show();
                        _setCounter();
                      }
                      if (count > 5) {
                        return AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Opps!',
                          desc: 'Please Commig after 5min',
                        )..show();
                      }
                    },
                    child: Image.asset("images/like.png"),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () {
                        Share.share(
                            'https://play.google.com/store/apps/details?id=com.example.bitco.crypt');
                      },
                      child: Image.asset("images/luck.png")),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () async {
                        if (await rewardAd.isLoaded) {
                          addOne(2);
                          _setCounter();
                        }
                        rewardAd.show();
                      },
                      child: Image.asset("images/firsrGift.png")),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () async {
                        if (await rewardAd.isLoaded) {
                          addOne(2);
                          _setCounter();
                        }
                        rewardAd.show();
                      },
                      child: Image.asset("images/X2.png")),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () async {
                        if (await rewardAd.isLoaded) {
                          addOne(2);
                          _setCounter();
                        }
                        rewardAd.show();
                      },
                      child: Image.asset("images/X5.png")),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () async {
                        if (await rewardAd.isLoaded) {
                          addOne(2);
                          _setCounter();
                        }
                        rewardAd.show();
                      },
                      child: Image.asset("images/X2.png")),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () async {
                        if (await rewardAd.isLoaded) {
                          addOne(2);
                          _setCounter();
                        }
                        rewardAd.show();
                      },
                      child: Image.asset("images/X5.png")),
                ),
              ],
            ),
          )
          // End
        ],
      ),
    );
  }
}

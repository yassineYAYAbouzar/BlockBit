import 'package:crypt/LandingPage/DiatelsCoin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:crypt/Statistic/AdsManager.dart';
import 'package:flutter/material.dart';

class LoadData extends StatefulWidget {
  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  AdmobInterstitial interstitialAd;
  bool _switch = true;
  bool _switcher = false;

  Future getData() async {
    var url = "https://yassinebouzar.000webhostapp.com/";
    var response = await http.post(url);
    var responsebody = jsonDecode(response.body)['data'][0]['data'];
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
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 50,
            itemBuilder: (context, i) {
              var price = snapshot.data['coins'][i]['price'];
              double priced = num.parse(price);
              String pricef = priced.toStringAsFixed(2);
              //Price
              var iconUrl = snapshot.data['coins'][i]['iconUrl'];
              //Image
              var change = snapshot.data['coins'][i]['change'];
              double changed = num.parse(change);
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      interstitialAd.show();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiatelsCoin(
                                  price: pricef,
                                  iconUrl: iconUrl,
                                  namen: snapshot.data['coins'][i]['name'],
                                  uuid: snapshot.data['coins'][i]['uuid'],
                                  changed: changed,
                                  marketCap: snapshot.data['coins'][i]
                                      ['marketCap'],
                                  listedAt: snapshot.data['coins'][i]
                                      ['listedAt'],
                                  sparkline: snapshot.data['coins'][i]
                                      ['sparkline'],
                                  coinrankingUrl: snapshot.data['coins'][i]
                                      ['coinrankingUrl'],
                                  hV24olume: snapshot.data['coins'][i]
                                      ['hV24olume'],
                                  btcPrice: snapshot.data['coins'][i]
                                      ['btcPrice'],
                                )),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: SvgPicture.network(iconUrl),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(60 / 2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data['coins'][i]['symbol'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                        Text(
                                          snapshot.data['coins'][i]['name'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 11, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: changed > 0
                                      ? Image.asset(
                                          "images/polyG.png",
                                          width: 35,
                                          height: 35,
                                        )
                                      : Image.asset(
                                          "images/polyR.png",
                                          width: 35,
                                          height: 35,
                                        )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    " \$ " + pricef,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                  Text(
                                    " \$ " + changed.toStringAsFixed(2),
                                    style: TextStyle(
                                        color: changed > 0
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyanAccent,
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFeeb609)),
          ),
        );
      },
    );
  }
}

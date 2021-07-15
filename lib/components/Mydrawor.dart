import 'package:crypt/LandingPage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Mydrawor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    openUrl(url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Drawer(
        elevation: 16,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              Container(
                height: 100,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Block",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 17),
                    ),
                    Text(
                      " BIT",
                      style: TextStyle(
                          color: Color(0xFFeeb609), fontSize: 14, height: 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
              ),
              ListTile(
                title: Text("Statistic",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading:
                    Icon(Icons.stacked_line_chart_sharp, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              ListTile(
                title: Text("Help && Support",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.help, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  openUrl("https://yassinebouzar.com/support");
                },
              ),
              ListTile(
                title: Text("About",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.info, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  openUrl("https://yassinebouzar.com/about");
                },
              ),
              ListTile(
                title: Text("Share The APP",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.share, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.example.bitco.crypt');
                },
              ),
              ListTile(
                title: Text(
                  "Like The App",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                leading: Icon(Icons.favorite, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  openUrl(
                      'https://play.google.com/store/apps/details?id=com.example.bitco.crypt');
                },
              ),
              ListTile(
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                leading: Icon(Icons.privacy_tip, color: Colors.grey),
                trailing:
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.grey),
                onTap: () {
                  openUrl("https://yassinebouzar.com/privcy");
                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 70),
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Text(
                        "Created By Yassine BOUZAR AT 2021",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 14,
                            height: 2,
                            wordSpacing: 2,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      )),
                      Icon(
                        Icons.copyright_outlined,
                        size: 50,
                        color: Color(0xFFD9B372),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

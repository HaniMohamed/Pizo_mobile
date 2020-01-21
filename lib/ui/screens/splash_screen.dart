import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String token;

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed("Main_SCREEN");
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPrefs().getSharedToken().then((tok) {
      setState(() {
        token = tok;
        if (token != null) startTime();
      });
    });
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFd3ece8),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius: new BorderRadius.only(
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0))),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0)),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                          child: Stack(
                                        children: <Widget>[
                                          Container(
                                            color: Color(0xFFd3ece8),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              "asset/images/logo.png",
                                            ),
                                          )
                                        ],
                                      )),
                                      Image.asset(
                                        "asset/images/splash.jpg",
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              child:
                                  token != null ? Container() : LoginWidget(),
                            )
                          ],
                        )),
                  ),
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        elevation: 2,
                        onPressed: () {
                          if (token == null) LoginWidget().login(context);
                        },
                        child: token != null
                            ? CircularProgressIndicator()
                            : Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Designed and Devloped by ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Proga",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

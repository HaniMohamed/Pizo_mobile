import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:pizo/ui/screens/favourite_products.dart';
import 'package:pizo/ui/screens/main_page.dart';

class AppHeader extends StatelessWidget {
  List<String> titles;
  var context;

  AppHeader(List titles) {
    this.titles = titles;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 85,
          color: Colors.indigo,
        ),
        Padding(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    height: 45,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                                child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: new BoxDecoration(
                                      color: Color(0x22000000),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 15),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          titles.length > 1
                                              ? RotateAnimatedTextKit(
                                                  text: titles,
                                                  textStyle: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      fontFamily: "Horizon"),
                                                  textAlign: TextAlign.center,
                                                  alignment: AlignmentDirectional
                                                      .center // or Alignment.topLeft
                                                  )
                                              : Text(
                                                  titles.elementAt(0),
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontFamily: "Horizon",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                        ],
                                      )),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavProducts()),
                    );
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

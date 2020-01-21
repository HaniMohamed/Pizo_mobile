import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizo/ui/widgets/gradient_header.dart';
import 'package:pizo/ui/widgets/home_icons.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            GradientHeader(),
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
                                Icon(
                                  Icons.menu,
                                  size: 25,
                                  color: Colors.white,
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
                                          borderRadius: new BorderRadius.all(Radius.circular(20))),
                                    
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 8, right: 5),
                                        alignment: Alignment.center,
                                        child: 
                                        TextField(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Searching for ...",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)),
                                        ),
                                      ),
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
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 70,
                margin: EdgeInsets.only(top: 220, left: 10, right: 10),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: HomeIcons(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                )),
          ],
        )
      ],
    );
  }
}

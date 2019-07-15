import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/constants.dart';

Product product;
String heroTag;
Constants cons = new Constants();

class ProductDetails extends StatefulWidget {
  ProductDetails(Product recievedProduct, String recievedTag) {
    product = recievedProduct;
    heroTag = recievedTag;
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductDetails();
  }
}

class _ProductDetails extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 10) {
          Navigator.pop(context);
        }
      },
      child: Container(
          height: double.infinity,
          color: Colors.grey.shade200,
          child: Column(
            children: <Widget>[
              Hero(
                  tag: heroTag,
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: product.getImage(),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                          bottom: 5,
                          right: 5,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    semanticContainer: false,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: Colors.red,
                                      ),
                                    )),
                                Card(
                                  elevation: 5,
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  semanticContainer: false,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.chat_bubble,
                                              size: 25, color: Colors.white),
                                          Text(
                                            " Contact",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ))
                    ],
                  )),
              Expanded(
                child: Card(
                  color: Colors.white.withAlpha(240),
                  elevation: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          product.getTitle(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 3,
                            semanticContainer: false,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.redAccent,
                                          size: 25,
                                        ),
                                        Text(
                                          product.getPrice().toString() +
                                              " L.E",
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.business,
                                            size: 25,
                                            color: Colors.teal,
                                          ),
                                          Text(
                                            product.getProvider().toString(),
                                          )
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.category,
                                            size: 25,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            cons.dev_categories.elementAt(
                                                product.getCategoryID()),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Expanded(
                              child: new Container(
                                margin: EdgeInsets.all(5),
                                height: 1.0,
                                color: Colors.grey.withAlpha(50),
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              product.getDescribe(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/apis/devices_api_provider.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/lists/products_list.dart';

Constants cons = new Constants();

class FavProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavProducts();
  }
}

class _FavProducts extends State<FavProducts> {
  List<String> favIDs;

  List<Product> products = new List();

  getData() {
    SharedPrefs().getSharedFavourits().then((favs) {
      setState(() {
        favIDs = favs;
      });
    });
    DevicesAPi().getDevices().then((prods) {
      setState(() {
        for (int i = 0; i < prods.length; i++) {
          for (int y = 0; y < favIDs.length; y++) {
            if (prods.elementAt(i).getID().toString() ==
                favIDs.elementAt(y).toString()) {
              products.add(prods.elementAt(i));
            }
          }
        }
        print(favIDs.length.toString() + "\n" + products.length.toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("My Favourite"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Text(
                  "My Favourits",
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
          ),
         products !=null && products.length > 0
              ? ProductsList(products, products.length)
              : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(100),
                  child: Text(
                    "No Items.!!",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
        ],
      ),
    );
  }
}

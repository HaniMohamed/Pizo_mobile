import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/apis/devices_api_provider.dart';
import 'package:pizo/widgets/lists/home_promo_list.dart';
import 'package:pizo/widgets/lists/products_list.dart';

class DashboardTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashboardTab();
  }
}

class _DashboardTab extends State<DashboardTab> {
  List<Product> devices = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DevicesAPi().getDevices().then((products) {
      devices = products;
      print("##################  \n" + devices.length.toString());

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl:
              "https://png.pngtree.com/element_origin_min_pic/16/10/09/1557f9ecb06db32.jpg",
          height: 90,
          fit: BoxFit.cover,
        ),
        Padding(
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  height: 1.0,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
              Text(
                "Recommends",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: 'pacifico'),
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
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        ),
        PromoList(devices, devices.length > 6 ? 6 : devices.length),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Text(
                "New Devices",
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
        Container(
          child: devices.length > 0 ? ProductsList(devices, 4) : Container(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pizo/models/order.dart';
import 'package:pizo/resources/firebase/orders.dart';
import 'package:pizo/ui/screens/request_Maintanance.dart';
import 'package:pizo/widgets/app_header.dart';
import 'package:pizo/widgets/lists/orders_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {
  SharedPreferences sharedPreferences;
  String mail;
  List<String> titles = [
    "Maintenance Orders",
  ];

  List<Order> orders = new List();

  Future<List<Order>> getOrders(String mail) async {
    return await MaintainOrders().getOrders(context, mail);
  }

  Future<String> getMail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("mail");
  }

  @override
  void initState() {
    super.initState();
    getMail().then((mail) {
      print(mail);
      getOrders(mail).then((orders) {
        setState(() {
          this.orders = orders;
          print(orders.length.toString() + "****************");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppHeader(titles),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Your Orders",
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
            orders.length > 0
                ? Expanded(
                    child: OrdersList(orders, orders.length),
                  )
                : Container(),
          ],
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    // _showDialog();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestMaintenance()),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                ),
              )),
        )
      ],
    );
  }
}

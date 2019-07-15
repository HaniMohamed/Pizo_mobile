import 'package:flutter/material.dart';
import 'package:pizo/models/order.dart';
import 'package:pizo/ui/dialogs/request_Maintanance.dart';
import 'package:pizo/widgets/app_header.dart';
import 'package:pizo/widgets/lists/orders_list.dart';

class OrdersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {
  List<String> titles = [
    "Maintenance Orders",
  ];

  List<Order> orders = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        "proga",
        true));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        "proga",
        false));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        null,
        false));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        null,
        true));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        "proga",
        false));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        null,
        true));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        "proga",
        false));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        null,
        true));

    orders.add(Order(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "First Order",
        "Optical",
        "descripe",
        "Hani Hussein",
        "proga",
        false));
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
            OrdersList(orders, orders.length),
          ],
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    _showDialog();
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                ),
              )),
        )
      ],
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Request maintenance order"),
          content: RequestMaintenance(),
          contentPadding: EdgeInsets.all(0),
        );
      },
    );
  }
}

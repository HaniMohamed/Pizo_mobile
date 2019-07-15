import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/order.dart';
import 'package:pizo/resources/firebase/orders.dart';

class OrderItem extends StatelessWidget {
  Order order;

  OrderItem(Order order) {
    this.order = order;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.all(2),
      child: Card(
        semanticContainer: false,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  color: order.ifFinished()
                      ? Colors.green
                      : order.getEnginner() != null ? Colors.blue : Colors.grey,
                ),
                Container(
                  child: Icon(
                    order.ifFinished()
                        ? Icons.done
                        : order.getEnginner() != null
                            ? Icons.av_timer
                            : Icons.hourglass_empty,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(order.getName(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  order.getEnginner() != null
                      ? Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Eng: " + order.getEnginner(),
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.start,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            order.ifFinished() || order.getEnginner() == null
                ? Container(
                    child: GestureDetector(
                      onTap: () {
                        _deleteDialog(context);
                      },
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                    margin: EdgeInsets.all(5),
                  )
                : Container(),
          ],
        ),
        elevation: 1,
      ),
    );
  }

  void _deleteDialog(var context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete"),
          content: new Text("Are you sure to delete this order?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                MaintainOrders().deleteOrder(context, order.getName());
              },
            ),
          ],
        );
      },
    );
  }
}

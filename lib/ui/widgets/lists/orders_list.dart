import 'package:flutter/material.dart';
import 'package:pizo/models/order.dart';
import 'package:pizo/ui/widgets/lists_item/order_item.dart';

class OrdersList extends StatelessWidget {
  List<Order> orders;
  int count;

  OrdersList(List<Order> orders, int count) {
    this.orders = orders;
    this.count = count;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10, right: 10),
      children: ordersWidgets(),
    );
  }

  List<Widget> ordersWidgets() {
    List<Widget> widgets = new List();
    for (int i = 0; i < count; i++) {
      widgets.add(OrderItem(orders.elementAt(i)));
    }
    return widgets;
  }
}

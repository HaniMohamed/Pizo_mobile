import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/ui/widgets/lists_item/promo_list_item.dart';

class PromoList extends StatelessWidget {
  List<Product> products;
  int count;

  PromoList(List<Product> products, int count) {
    this.products = products;
    this.count = count;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 140.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: promosWidgets(),
      ),
    );
  }

  List<Widget> promosWidgets() {
    List<Widget> widgets = new List();
    widgets.add(
      Container(
        width: 10,
      ),
    );
    for (int i = 0; i < count; i++) {
      widgets.add(PromoItem(products.elementAt(i)));
    }
    return widgets;
  }
}

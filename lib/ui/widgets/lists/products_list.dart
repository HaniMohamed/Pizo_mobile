import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/ui/widgets/lists_item/product_item.dart';

class ProductsList extends StatelessWidget {
  List<Product> products;
  int count;

  ProductsList(List<Product> products, int count) {
    this.products = products;
    this.count = count;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 2,
      childAspectRatio: 200 / 95,
      children: productsWidgets(),
      shrinkWrap: true,
    );
  }

  List<Widget> productsWidgets() {
    List<Widget> widgets = new List();
    for (int i = 0; i < count; i++) {
       widgets.add(ProductItem(products.elementAt(i)));
    }
    return widgets;
  }
}

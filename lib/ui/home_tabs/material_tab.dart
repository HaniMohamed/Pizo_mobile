import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/widgets/lists/products_list.dart';


Constants cons = new Constants();

class MaterialTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterialTab();
  }
}

class _MaterialTab extends State<MaterialTab> {
  List<Product> products = new List();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCategory;
  List _categories = cons.material_categories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      

      _dropDownMenuItems = getDropDownMenuItems();
      _currentCategory = _dropDownMenuItems[0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  height: 1.0,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _currentCategory,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        ),
        Container(
          child:
              products.length > 0 ? ProductsList(products, products.length) : Container(),
        ),
      ],
    );
  }

  void changedDropDownItem(String selectedCategory) {
    print("Selected city $selectedCategory, we are going to refresh the UI");
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in _categories) {
      items.add(
          new DropdownMenuItem(value: category, child: new Text(category)));
    }
    return items;
  }
}
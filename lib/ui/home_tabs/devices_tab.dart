import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/apis/devices_api_provider.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/widgets/lists/products_list.dart';
import 'package:dio/dio.dart';

Constants cons = new Constants();

class DevicesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DevicesTab();
  }
}

class _DevicesTab extends State<DevicesTab>
    with SingleTickerProviderStateMixin {
  List<Product> devices = new List();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCategory;
  List _categories = cons.dev_categories;
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCategory = _dropDownMenuItems[0].value;
    DevicesAPi().getDevices().then((products) {
      devices = products;
      print("##################  \n" + devices.length.toString());

      setState(() {});
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
        TabBar(
          unselectedLabelColor: Colors.grey.withAlpha(80),
          labelColor: Colors.grey,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text("New"),
            ),
            Tab(
              child: Text("Used"),
            )
          ],
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
          child: devices.length > 0
              ? ProductsList(devices, devices.length)
              : Container(),
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
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          new DropdownMenuItem(value: category, child: new Text(category)));
    }
    return items;
  }
}
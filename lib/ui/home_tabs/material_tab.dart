import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/apis/devices_api_provider.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/ui/widgets/lists/products_list.dart';

Constants cons = new Constants();

class MaterialTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterialTab();
  }
}

class _MaterialTab extends State<MaterialTab> {
  List<Product> products = new List();
  List<Product> materials = new List();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentSpecialization;
  int _currentSpecializationIndex;

  List _categories = cons.material_categories;

  Future<bool> getData() {
    DevicesAPi().getDevices().then((prods) {
      setState(() {
        products = prods;
        materials = products.where((p) => p.getCategoryID() == 3).toList();
        print(materials.length.toString());
        materials = materials
            .where((p) =>
                p.getSpecializationID() == _currentSpecializationIndex + 1)
            .toList();
      });
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _currentSpecializationIndex = 0;
    getData();

    setState(() {
      _dropDownMenuItems = getDropDownMenuItems();
      _currentSpecialization = _dropDownMenuItems[0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
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
                  value: _currentSpecialization,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        ),
        Container(
          child: materials != null && materials.length > 0
              ? ProductsList(materials, materials.length)
              : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(100),
                  child: Text(
                    "No Items.!!",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
        ),
      ],
    );
  }

  void changedDropDownItem(String selectedCategory) {
    print("Selected city $selectedCategory, we are going to refresh the UI");
    setState(() {
      _currentSpecialization = selectedCategory;
      _currentSpecializationIndex = _categories.indexOf(selectedCategory);

      materials = products.where((p) => p.getCategoryID() == 3).toList();
      materials = materials
          .where(
              (p) => p.getSpecializationID() == _currentSpecializationIndex + 1)
          .toList();
      print(materials.length.toString());
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

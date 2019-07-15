import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/firebase/orders.dart';
import 'package:pizo/widgets/map_curLoc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Constants cons = new Constants();

class RequestMaintenance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestMaintenance();
  }
}

class _RequestMaintenance extends State<RequestMaintenance> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCategory;
  int _currentCategoryIndex = 0;
  List _categories = cons.dev_categories;
  SharedPreferences sharedPreferences;
  String mail;

  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  int current_step = 0;

  @override
  void initState() {
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCategory = _dropDownMenuItems[0].value;
    getEmail();
  }

  void getEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      mail = sharedPreferences.getString("mail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Mantainance order"),
      ),
      body: ListView(
        children: <Widget>[
          Stepper(
              // Using a variable here for handling the currentStep
              currentStep: this.current_step,
              // List the steps you would like to have
              steps: [
                new Step(
                    // Title of the Step
                    title: new Text("Category"),
                    // Content, it can be any widget here. Using basic Text for this example
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Category:   "),
                        DropdownButton(
                          value: _currentCategory,
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
                        ),
                      ],
                    ),
                    state: StepState.editing,
                    isActive: true),
                new Step(
                    title: new Text("Details"),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: "Order title",
                              labelText: "Order title",
                              suffixStyle: TextStyle(fontSize: 12),
                              hintStyle: TextStyle(fontSize: 12),
                            )),
                        TextField(
                          controller: detailsController,
                          decoration: InputDecoration(
                            hintText: "Order details",
                            labelText: "Order details",
                            suffixStyle: TextStyle(fontSize: 12),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    // You can change the style of the step icon i.e number, editing, etc.
                    state: StepState.editing,
                    isActive: true),
                new Step(
                    title: new Text("Location"),
                    content: current_step == 2 ? MapLocation() : Container(),
                    isActive: true),
              ],
              // Define the type of Stepper style
              // StepperType.horizontal :  Horizontal Style
              // StepperType.vertical   :  Vertical Style
              type: StepperType.vertical,
              // Know the step that is tapped
              onStepTapped: (step) {
                // On hitting step itself, change the state and jump to that step
                setState(() {
                  // update the variable handling the current step value
                  // jump to the tapped step
                  current_step = step;
                });
                // Log function call
                print("onStepTapped : " + step.toString());
              },
              onStepCancel: () {
                // On hitting cancel button, change the state
                setState(() {
                  // update the variable handling the current step value
                  // going back one step i.e subtracting 1, until its 0
                  if (current_step > 0) {
                    current_step = current_step - 1;
                  } else {
                    current_step = 0;
                  }
                });
                // Log function call
                print("onStepCancel : " + current_step.toString());
              },
              // On hitting continue button, change the state
              onStepContinue: () {
                setState(() {
                  // update the variable handling the current step value
                  // going back one step i.e adding 1, until its the length of the step
                  if (current_step < 3 - 1) {
                    current_step = current_step + 1;
                  } else {
                    LatLng position = MapLocation().getMapPosition();
                    if (titleController.text.isNotEmpty &&
                        detailsController.text.isNotEmpty &&
                        position.latitude.toString() != null) {
                      MaintainOrders().createOrder(
                          context,
                          mail,
                          _currentCategoryIndex,
                          titleController.text,
                          detailsController.text,
                          position.latitude,
                          position.longitude);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Fill all fileds first !!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                  }
                });
                // Log function call
                print("onStepContinue : " + current_step.toString());
              },
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: onStepCancel,
                      child: const Text(
                        '<Back',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    FlatButton(
                      onPressed: onStepContinue,
                      child: const Text(
                        'Next>',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectedCategory) {
    print("Selected city $selectedCategory, we are going to refresh the UI");
    setState(() {
      _currentCategory = selectedCategory;
      _currentCategoryIndex = _categories.indexOf(selectedCategory);
      print(_currentCategoryIndex.toString() + "%%%%#######");
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

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizo/resources/apis/devices_api_provider.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/sharedprefs.dart';

Constants cons = new Constants();

class PostDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostDevice();
  }
}

class _PostDevice extends State<PostDevice> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCategory;
  int _currentCategoryIndex = 1;
  List _categories = cons.dev_categories;
  String mail;

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final detailsController = TextEditingController();

  int current_step = 0;

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCategory = _dropDownMenuItems[0].value;
    SharedPrefs().getSharedMail().then((email) {
      this.mail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Post used device"),
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
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Device name",
                              labelText: "Name",
                              suffixStyle: TextStyle(fontSize: 12),
                              hintStyle: TextStyle(fontSize: 12),
                            )),
                        TextField(
                          controller: detailsController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Device details and status",
                            labelText: "Details",
                            suffixStyle: TextStyle(fontSize: 12),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        ),
                        TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Device price",
                            labelText: "Price",
                            suffixStyle: TextStyle(fontSize: 12),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    // You can change the style of the step icon i.e number, editing, etc.
                    state: StepState.editing,
                    isActive: true),
                new Step(
                    title: new Text("Image"),
                    content: Container(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          _image != null
                              ? Image.file(
                                  _image,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  height: 200,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1MUwwFxcjTc3U8Y-tLYesHI0ddXAa8g7PWHyRZ_mTkqd79bwt",
                                ),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  mini: true,
                                  onPressed: () {
                                    getImage();
                                  },
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
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
                    if (titleController.text.isNotEmpty &&
                        detailsController.text.isNotEmpty &&
                        priceController.text.isNotEmpty &&
                        _image != null) {
                      SharedPrefs().getSharedToken().then((token) {
                        DevicesAPi()
                            .postDevice(
                                token,
                                titleController.text,
                                detailsController.text,
                                priceController.text,
                                _currentCategoryIndex,
                                _image)
                            .then((error) {
                          print(error.toString());
                          if (error == "0") {
                            Fluttertoast.showToast(
                                msg: "Device postsd Sucessfully !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 12.0);
                            Navigator.pop(context);
                          }
                        });
                      });
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
      _currentCategoryIndex = _categories.indexOf(selectedCategory) + 1;
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

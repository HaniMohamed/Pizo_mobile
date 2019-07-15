import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/resources/apis/signin_api.dart';
import 'package:pizo/resources/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Constants cons = new Constants();

final mailController = TextEditingController();
final passController = TextEditingController();

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }

  signIn(var context) {
    if (mailController.text != null && passController.text != null) {
      SigninAPI()
          .signin(
        mailController.text,
        passController.text,
      )
          .then((token) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (token != null) {
          await prefs.setString('token', token);
          await prefs.setString('mail', mailController.text);
          Navigator.of(context).pushReplacementNamed("Main_SCREEN");
        }
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
}

class _SignIn extends State<SignIn> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  List _cities = cons.cities;
  int _selectedCity = 0;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: <Widget>[
          cusTextField(
              mailController,
              "example@example.com",
              "Email",
              TextInputType.emailAddress,
              Icon(
                Icons.mail,
                color: Colors.white,
              ),
              false),
          TextField(
            controller: passController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: new InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(80),
              labelText: "Password",
              prefixIcon: Icon(
                Icons.security,
                color: Colors.white,
              ),
              prefixStyle: TextStyle(color: Colors.white, fontSize: 12),
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
              suffixStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectedCategory) {
    print("Selected city $selectedCategory, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCategory;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: category,
          child: new Text(
            category,
          )));
    }
    return items;
  }

  Widget cusTextField(TextEditingController controller, String hint,
      String label, TextInputType type, Icon myIcon, bool secure) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: secure,
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.white.withAlpha(80),
        hintText: hint,
        labelText: label,
        prefixIcon: myIcon,
        prefixStyle: TextStyle(color: Colors.white, fontSize: 12),
        labelStyle: TextStyle(color: Colors.white, fontSize: 12),
        hintStyle: TextStyle(color: Colors.white, fontSize: 12),
        suffixStyle: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

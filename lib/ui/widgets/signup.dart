import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/resources/apis/profile_api.dart';
import 'package:pizo/resources/apis/signin_api.dart';
import 'package:pizo/resources/apis/signup_api.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/sharedprefs.dart';

Constants cons = new Constants();

final nameController = TextEditingController();
final phoneController = TextEditingController();
final mailController = TextEditingController();
final passController = TextEditingController();
final passConfController = TextEditingController();

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }

  signUp(var context) {
    if (nameController.text.isNotEmpty &&
        mailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passConfController.text != null &&
        passController.text != null) {
      if (passConfController.text == passController.text) {
        SignupAPI()
            .signup(nameController.text, "", mailController.text,
                phoneController.text, "", passController.text, 1)
            .then((error) {
          if (!error) {
            SigninAPI()
                .signin(mailController.text, passController.text)
                .then((token) async {
              if (token != null) {
                await SharedPrefs().setSharedStringValue('token', token);
                await SharedPrefs()
                    .setSharedStringValue('mail', mailController.text);

                ProfileAPI().updateData(token, mailController.text,
                    nameController.text, phoneController.text);

                ProfileAPI().getProfileData(token).then((profile) async {
                  if (profile != null) {
                    await SharedPrefs()
                        .setSharedStringValue('id', profile.getID().toString());
                    await SharedPrefs()
                        .setSharedStringValue('name', profile.getName());

                    // await prefs.setString('id', id);
                    Navigator.of(context).pushReplacementNamed("Main_SCREEN");
                  }
                });
              }
            });
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: "Passwords don't match!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0);
      }
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

class _SignUp extends State<SignUp> {
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
              nameController,
              "your name",
              "Name",
              TextInputType.text,
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              false),
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
          cusTextField(
              phoneController,
              "01xxxxxxxxx",
              "Phone",
              TextInputType.phone,
              Icon(
                Icons.phone,
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
              hintText: "at least 8 characters",
              labelText: "Password",
              prefixIcon: Icon(
                Icons.security,
                color: Colors.white,
              ),
              helperText:
                  "   ** must contain one symbol and an capital character",
              prefixStyle: TextStyle(color: Colors.white, fontSize: 12),
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
              suffixStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          cusTextField(
              passConfController,
              "password again",
              "re-Password",
              TextInputType.text,
              Icon(
                Icons.security,
                color: Colors.white,
              ),
              true),
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

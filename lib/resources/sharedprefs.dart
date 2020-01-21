import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> getSharedID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("id");
  }

  Future<String> getSharedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  Future<String> getSharedMail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("mail");
  }

  Future<String> getSharedName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("name");
  }

  setSharedStringValue(key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  setSharedIntValue(key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(key, value);
  }

  setSharedBoolValue(key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, value);
  }

  Future<List<String>> getSharedFavourits() async {
    List<String> favIDs = new List();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favIDs = sharedPreferences.getStringList("favs");

    return favIDs;
  }

  setSharedFavourite(id) async {
    List<String> favIDs = new List();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList("favs") != null) {
      favIDs = sharedPreferences.getStringList("favs");
    }
    if (!favIDs.contains(id.toString())) {
      favIDs.add(id.toString());
    }
    await sharedPreferences.setStringList("favs", favIDs);
    favIDs.forEach((element) => print(element));
    Fluttertoast.showToast(
        msg: "Favourite added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.cyan,
        textColor: Colors.white,
        fontSize: 12.0);
  }
}

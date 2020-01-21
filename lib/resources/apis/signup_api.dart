// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

import 'package:pizo/resources/constants.dart';

class SignupAPI {
  Constants cons = new Constants();

  Future<bool> signup(String name, String username, String email, String phone,
      String address, String password, int city) async {
    http.Response response =
        await http.post(cons.domain + "api/v1/users/signup", body: {
      "name": name,
      "username": username,
      "email": email,
      "phone": phone,
      "address": address,
      "group": "3",
      "password": password,
      "city": city.toString(),
    });
    print("!!!!!!!######!!!!!!!!!!######: \n" + response.body);
    final decoded = JSON.jsonDecode(response.body);
    var error = decoded['error'];
    print(error);
    if (error == "1") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
      print(decoded['msg']);
    } else if (error == "0") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    return error == "1";
  }
}

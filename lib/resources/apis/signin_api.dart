// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:pizo/resources/constants.dart';

class SigninAPI {
  Constants cons = new Constants();

  Future<String> signin(String email, String password) async {
    http.Response response = await http.post(
        cons.domain + "api/v1/users/signin",
        body: {"email": email, "password": password});
    final decoded = JSON.jsonDecode(response.body);
    var error = decoded['error'];
    if (error == "1") {
      print(decoded['msg']);
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == "0") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      print(decoded['token']);
      return decoded['token'];
    }
    return null;
  }
}

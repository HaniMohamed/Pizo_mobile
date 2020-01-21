import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/models/profile.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

Constants cons = new Constants();

class ProfileAPI {
  Profile profile;

  Future<String> getProfileID(token) async {
    String url = cons.domain + "/api/v1/users/profile?token=" + token;
    http.Response response = await http.get(url);
    final decoded = JSON.jsonDecode(response.body.toString());
    var error = decoded['error'];
    if (error == "1") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == "0") {
      return decoded['data']['id'].toString();
    }
    return null;
  }

  Future<Profile> getProfileData(token) async {
    String url = cons.domain + "/api/v1/users/profile?token=" + token;
    http.Response response = await http.get(url);
    final decoded = JSON.jsonDecode(response.body.toString());
    var data = decoded['data'];
    Profile prof = Profile.fromJson(data);
    var error = decoded['error'];
    print("!!!!!!!!!!!!!!!!!!!  \n" + prof.getEmail());
    if (error == "1") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == "0") {
      return prof;
    }

    return null;
  }

  Future<String> updateData(token, email, name, phone) async {
    String url = cons.domain + "api/v1/users/update?token=" + token;
    http.Response response = await http
        .post(url, body: {"email": email, "name": name, "phone": phone});

    final decoded = JSON.jsonDecode(response.body.toString());
    print(response.body.toString());
    var error = decoded['error'];
    if (error == "1") {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
    return error;
  }

  Future<String> uploadProfImg() {}
}

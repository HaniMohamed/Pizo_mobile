import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

class DevicesAPi {
  Constants cons = new Constants();

  Future<List<Product>> getDevices() async {
    try {
      Response response = await Dio().get(cons.domain + "api/v1/store/product");
      final decoded = JSON.jsonDecode(response.toString());
      var list = decoded['products'] as List;
      List<Product> products = list.map((i) => Product.fromJson(i)).toList();
      return products;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<String> postDevice(
      token, title, description, price, specialization_id, img) async {
    var uploadError;
    String url = cons.domain + "api/v1/store/product?token=" + token;
    http.Response response = await http.post(url, body: {
      "title": title,
      "description": description.toString(),
      "price": price.toString(),
      "specialization_id": specialization_id.toString(),
      "category_id": 1.toString()
    });

    final decoded = JSON.jsonDecode(response.body.toString());
    print("POOOOOOOOOOOOOSSSTT: " + response.body.toString());
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
      await uploadDeviceImage(decoded['id'], token, img).then((upError) {
        uploadError = upError;
      });
    }

    return uploadError;
  }

  Future<String> uploadDeviceImage(id, token, img) async {
    String url = cons.domain +
        "api/v1/store/product/" +
        id.toString() +
        "/image?token=" +
        token;
    FormData formData = new FormData.from({
      "image": new UploadFileInfo(img, "img.jpg"),
    });
    Response response = await Dio().post(url, data: formData);
    final decoded = JSON.jsonDecode(response.toString());
    print("UPLOOOOOAAAAADDD: " + response.toString());
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
}

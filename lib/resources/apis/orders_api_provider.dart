import 'package:dio/dio.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;

class OrdersAPi {
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

  Future<String> getMsg() async {
    try {
      Response response = await Dio().get(cons.domain + "api/v1/store/product");

      final decoded = JSON.jsonDecode(response.toString());

      print(decoded['msg']);
      return decoded['msg'];
    } catch (e) {
      print(e);
    }

    return null;
  }
}

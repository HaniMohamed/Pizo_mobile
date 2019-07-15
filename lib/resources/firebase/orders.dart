import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaintainOrders {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createOrder(var context, String email, int categoryID, String title,
      String details, var lat, var ln) {
    databaseReference
        .child("orders")
        .child(email.replaceAll(new RegExp(r'[^\w\s]+'), ''))
        .child(title)
        .set({
      'category': categoryID,
      'title': title,
      'details': details,
      'lat': lat,
      'lan': ln,
      'engineer': null,
      'isfinished': false
    }).then((r) {
      Fluttertoast.showToast(
          msg: "Order successfuly posted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);

      Navigator.pop(context);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    });
  }

  Future<List<Order>> getOrders(var context, String email) async {
    List<Order> orders = new List();
    await databaseReference
        .child("orders")
        .child(email.replaceAll(new RegExp(r'[^\w\s]+'), ''))
        .once()
        .then((DataSnapshot snapshot) {
      var result = snapshot.value.values as Iterable;
      for (var item in result) {
        orders.add(Order(item['title'], item['category'], item['details'],
            item['owner'], item['engineer'], item['isfinished']));
      }
    });
    return orders;
  }

  void deleteOrder(var context, String title) {
    getMail().then((mail) {
      databaseReference
          .child('orders')
          .child(mail.replaceAll(new RegExp(r'[^\w\s]+'), ''))
          .child(title)
          .remove()
          .then((r) {
        Fluttertoast.showToast(
            msg: "Order successfuly deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);

        Navigator.pop(context);
      }).catchError((onError) {
        Fluttertoast.showToast(
            msg: onError.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
      });
    });
  }

  Future<String> getMail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("mail");
  }
}

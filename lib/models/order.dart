import 'package:intl/intl.dart';

class Order {
  String orderName;
  int orderCategory;
  String orderDescribtion;
  String orderOwner;
  String orderEnginner;
  bool finished;
  var lat, lan;
  var orderOwnerID;

  Order(String orderName, int orderCategory, String orderDescribtion,
      String orderOwner, String orderEnginner, bool finished, lat, lan, orderOwnerID) {
    this.orderName = orderName;
    this.orderCategory = orderCategory;
    this.orderDescribtion = orderDescribtion;
    this.orderOwner = orderOwner;
    this.orderEnginner = orderEnginner;
    this.finished = finished;
    this.lat = lat;
    this.lan = lan;
    this.orderOwnerID = orderOwnerID;
  }

  String getName() {
    return orderName;
  }

  int getCategory() {
    return orderCategory;
  }

  String getDescribe() {
    return orderDescribtion;
  }

  String getOwner() {
    return orderOwner;
  }

  String getEnginner() {
    return orderEnginner;
  }

  bool ifFinished() {
    return finished;
  }

  getLat() {
    return lat;
  }

  getLan() {
    return lan;
  }
   getOwnerID() {
    return orderOwnerID;
  }
}

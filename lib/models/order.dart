import 'package:intl/intl.dart';

class Order {
  String orderName;
  int orderCategory;
  String orderDescribtion;
  String orderOwner;
  String orderEnginner;
  bool finished;

  Order(String orderName, int orderCategory, String orderDescribtion,
      String orderOwner, String orderEnginner, bool finished) {
    this.orderName = orderName;
    this.orderCategory = orderCategory;
    this.orderDescribtion = orderDescribtion;
    this.orderOwner = orderOwner;
    this.orderEnginner = orderEnginner;
    this.finished = finished;
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
}

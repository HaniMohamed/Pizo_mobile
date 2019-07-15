import 'package:intl/intl.dart';

class Order {
  String orderImage;
  String orderName;
  String orderCategory;
  String orderDescribtion;
  String orderOwner;
  String orderEnginner;
  bool finished;

  Order(
      String orderImage,
      String orderName,
      String orderCategory,
      String orderDescribtion,
      String orderOwner,
      String orderEnginner,
      bool finished) {
    this.orderImage = orderImage;
    this.orderName = orderName;
    this.orderCategory = orderCategory;
    this.orderDescribtion = orderDescribtion;
    this.orderOwner = orderOwner;
    this.orderEnginner = orderEnginner;
    this.finished = finished;
  }

  String getImage() {
    return orderImage;
  }

  String getName() {
    return orderName;
  }

  String getCategory() {
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

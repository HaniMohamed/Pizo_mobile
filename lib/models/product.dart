import 'package:pizo/resources/constants.dart';

Constants cons = new Constants();

class Product {
  var productID;
  String productTitle;
  String productDescribtion;
  String productImage;
  var productOwnerID;
  var productSpecializationID;
  var productCategoryID;
  var productPrice;
  String productProvider;

  Product({
    this.productImage,
    this.productTitle,
    this.productPrice,
    this.productDescribtion,
    this.productProvider,
    this.productID,
    this.productOwnerID,
    this.productSpecializationID,
    this.productCategoryID,
  });

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    String img;

    if (parsedJson['image'].contains("http")) {
      img = parsedJson['image'];
    } else {
      img = cons.domain + parsedJson['image'];
    }
    return Product(
        productImage: img,
        productTitle: parsedJson['title'],
        productPrice: parsedJson['price'],
        productDescribtion: parsedJson['description'],
        productProvider: parsedJson['owner_name'],
        productID: parsedJson['id'],
        productOwnerID: parsedJson['owner_id'],
        productSpecializationID: parsedJson['specialization_id'],
        productCategoryID: parsedJson['category_id']);
  }

  String getImage() {
    return productImage;
  }

  String getTitle() {
    return productTitle;
  }

  getPrice() {
    return productPrice;
  }

  String getDescribe() {
    return productDescribtion;
  }

  String getProvider() {
    return productProvider;
  }

  getID() {
    return productID;
  }

  getOwnerID() {
    return productOwnerID;
  }

  getSpecializationID() {
    return productSpecializationID;
  }

  getCategoryID() {
    return productCategoryID;
  }
}

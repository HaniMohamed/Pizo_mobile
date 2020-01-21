import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/ui/screens/product_details.dart';

class PromoItem extends StatelessWidget {
  Product product;
  String heroTag;

  PromoItem(Product product) {
    this.product = product;
    heroTag = product.getID().toString() + " PROMO";
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(product, heroTag),
              ));
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  imageUrl: product.getImage(),
                  width: 200,
                  height: 120,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => new Container(
                    width: 200,
                    height: 120,
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.0, 1.1],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Color(0x00000000),
                        Color(0x99000000),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      product.getTitle(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    product.getPrice().toString() + " L.E",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.lime),
                  ),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          margin: EdgeInsets.all(10),
        ));
  }
}

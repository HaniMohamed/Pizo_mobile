import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/product.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/screens/product_details.dart';

class ProductItem extends StatelessWidget {
  Product product;
  String heroTag;

  ProductItem(Product product) {
    this.product = product;
    heroTag = product.getID().toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product, heroTag),
            ));
      },
      child: Container(
        child: Card(
          semanticContainer: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  imageUrl: product.getImage(),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => new Container(
                    width: 80,
                    height: 80,
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                width: 82,
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        product.getTitle(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: AutoSizeText(
                        product.getPrice().toString() + " L.E",
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.centerRight,
                        child: new Container(
                            width: 20,
                            decoration: new BoxDecoration(
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0))),
                            child: GestureDetector(
                              onTap: () {
                                SharedPrefs()
                                    .setSharedFavourite(product.getID());
                              },
                              child: new Container(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

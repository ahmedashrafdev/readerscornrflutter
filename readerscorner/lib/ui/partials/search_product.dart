import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shadow/shadow.dart';

Widget searchProductPartial(Product product, BuildContext context) {
  return GestureDetector(
      onTap: () async {
        // await model.fetchProduct(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => ProductScreen(
              curProduct: product,
            ),
          ),
        );

        // model.getProductDetail(todaysDealProducts[index].slug, context);
      },
      child: Row(
        children: <Widget>[
          Container(
            child: FadeInImage(
              // image: NetworkImage(product.image),
              image: NetworkImage(product.image),
              placeholder: AssetImage('images/no-product-image.png'),
              height: 152,
            ),
          ),
          SizedBox(width: 10),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 40,
            // padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              product.name,
              // product.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 10),
          Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top:0),
                child: Text(
                  'EGP${product.price}',
                  // 'EGP${product.price}',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ))
        ],
      ));
}

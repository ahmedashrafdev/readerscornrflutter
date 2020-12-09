import 'package:flutter/material.dart';

import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/ui/widgets/product_top.dart';
import 'package:readerscorner/ui/widgets/product_content.dart';


class ProductScreen extends StatefulWidget {
  ProductScreen({this.curProduct});
  final Product curProduct;

  @override
  _ProductScreenState createState() => new _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        body: new Wrap(
      children: <Widget>[
        MHeader(widget.curProduct),
        new Mfooter(widget.curProduct),
        
      ],
    ));
  }
}

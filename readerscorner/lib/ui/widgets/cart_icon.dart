import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:http/http.dart' as http;
import 'package:readerscorner/ui/screens/cart.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartIcon extends StatefulWidget {
  CartIcon({Key key}) : super(key: key);

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  int _count = 0;

  void initState() {
    super.initState();
    // getFavoritesCount();
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseView<MainModel>(onModelReady: (model) async {
       
       

        // model.fetchProducts();
      }, builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          width: 21.0,
          height: 21.0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => CartPage(),
                  ));
            },
            child: Stack(
              children: <Widget>[
                new Icon(Icons.brightness_1, size: 21.0, color: Colors.yellow),
                new Center(
                  child: new Text(
                    model.totalQty.toString(),
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ) ,
          ),
        );
      }),
    );
  }
}

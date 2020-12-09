import 'package:flutter/material.dart';
import './specification.dart';
import './productDesc.dart';
import './userReviews.dart';
import 'package:readerscorner/models/Product.dart';
var favnprice =  Padding(
  padding:
      const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 12.0),
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
       Row(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
           Text("Add to wishList")
        ],
      ),
       Row(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              "\$",
              style:  TextStyle(fontSize: 20.0),
            ),
          ),
           Text(
            "9999.00",
            style:  TextStyle(fontSize: 35.0),
          )
        ],
      )
    ],
  ),
);

var divider =  Divider();

var bottomBtns =  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30.0),
  
);

class Mfooter extends StatefulWidget {
  final Product product;
  Mfooter(this.product);
  @override
  _MfooterState createState() =>  _MfooterState();
}

class _MfooterState extends State<Mfooter> with SingleTickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  static TabController _controller;
  @override
  void initState() {
    super.initState();

    _tabs = [
       Tab(
        child:  Text(
          "Product Description",
          style:  TextStyle(color: Colors.black),
        ),
      ),
       Tab(
        child:  Text(
          "Details",
          style:  TextStyle(color: Colors.black),
        ),
      ),
      
    ];
    _pages = [ ProductDesc(widget.product.description), ProductDetails(widget.product.details)];
    _controller =  TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
         TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: _tabs,
          indicatorColor: Colors.white,
        ),
         Divider(
          height: 1.0,
        ),
         SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child:  TabBarView(
            controller: _controller,
            children: _pages,
          ),
        ),
      ],
    );
  }
}

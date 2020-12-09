import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/screens/cart.dart';
import 'package:readerscorner/ui/screens/search.dart';
import 'package:readerscorner/ui/widgets/cart_icon.dart';
import 'package:scoped_model/scoped_model.dart';

Widget buildAppBar(BuildContext context , String title , MainModel model) {

    return new  AppBar(
      elevation: 6.0,
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.white,
      // centerTitle: true,
      actions: <Widget>[
        new Stack(
              children: <Widget>[
                model.totalQty > 0 ? Text(model.totalQty.toString()):Text(''),
                IconButton(
                  iconSize: 30,
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => CartPage(),
            ),
          );
                  },
                ),
                
                // new Positioned(
                //   child:  CartIcon()
                // )
              ],
            ),
        new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }),
      ],
    );
     
}

import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/checkout.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartPageState();
  }
}

class CartPageState extends State<CartPage> {
  Widget generateCart(Product item, MainModel model, context) {
    int qty  = int.parse(item.qty);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        model.cart.remove(item);
        await model.deleteItem(item.id, context);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                "Delete",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      // secondaryBackground: Container(color: Colors.red,child: Icon(Icons.cancel),),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
          ),
          child: Row(
            children: <Widget>[
              Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 140.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item.image), fit: BoxFit.fill)),
                  )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 10.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) => ProductScreen(
                              curProduct: item,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            item.avg_rate != null ? ratingBar(0) : ratingBar(0),
                            Text(
                              "EGP${item.price}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        height: 64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  color: Color.fromARGB(255, 230, 230, 230),
                                  width: 140,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Qty : ',
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          
                                           qty = qty -1;
                                          model.decreaseQty(item.cart_id, context);
                                        },
                                        child: Image(
                                          image: NetworkImage(
                                              "https://cdn.iconscout.com/icon/free/png-256/minus-146-475070.png"),
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        '${qty}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                      ),
                                      GestureDetector(
                                        onTap: () {

                                          final Map<String, dynamic> _data = {"product" :item.id , "qunatinty" : "1"};
                                          print(item.order_limit);
                                          if(item.order_limit > qty){
                                          qty = qty +1;

                                          model.addToCart(_data, context);
                                          model.fetchCart();

                                          }else{
                                            model.showFlushBar(context, "Sorry this item is not allowed to increase");
                                          }
                                         
                                        },
                                        child: Icon(Icons.add)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView<MainModel>(
      onModelReady: (model) {
        model.fetchCart();
       
        // model.fetchProducts();
      },
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          title: Text("Cart"),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            model.cart.length > 0 ?  IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) => ChecoutScreen(),
                          ),
                        );
                }) : Text(''),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0))),
            child: model.cartLoading == false ?
            model.cart.length > 0
                ? ListView(
                    shrinkWrap: true,
                    children: model.cart
                        .map((item) => generateCart(item, model, context))
                        .toList())
                : Center(child: Text('no items on your cart')) : Center(child: Text('Loading'))),
      ),
    );
  }
}

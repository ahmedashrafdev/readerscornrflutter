import 'package:flutter/material.dart';
import 'package:readerscorner/models/Order.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';

class OrderDetailsScreen extends StatelessWidget {

  final Order order;
  OrderDetailsScreen(this.order);
 Widget generateCart(Product item, MainModel model, context) {
    // int qty  = int.parse(item.qty);
    return  Padding(
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
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'QTY : ',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14)),
                                        TextSpan(
                                            text: item.qty,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                ],
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
    );
  }

  Widget _buildHeader(title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(title, style: TextStyle(color: Colors.black54)),
    );
  }

  Widget _buildContent(content) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        top: 20,
        bottom: 40,
        right: 25,
      ),
      child: Text(
        content,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _buildWidgets(model , context){
    List<Widget> widgets = [];
    widgets.add(_buildHeader('DELIVERY'));
    widgets.add(_buildContent(model.address['full_address']));
    widgets.add(Divider());
    widgets.add(_buildHeader('PAYMENT'));
    widgets.add(_buildContent(order.gateway));
    widgets.add(Divider());
     widgets.add(_buildHeader('STATUS'));
    widgets.add(_buildContent(order.status));
    widgets.add(Divider());


    for (var i = 0; i < model.orderProducts.length; i++) {
      widgets.add(generateCart(model.orderProducts[i], model, context));
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView<MainModel>(
      onModelReady: (model) {
       model.selectedOrder = order.id;
          model.fetchOrderDetails();
          model.fetchFullAddress(order.address_id);
        // model.fetchProducts();
      },
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          title: Text("Order Details"),
          backgroundColor: Colors.white,
          centerTitle: true,

        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(top:20 , bottom:150),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0))),
            child:model.orderProducts.length > 0
                ? ListView(
                    shrinkWrap: true,
                    children: _buildWidgets(model,context))
                : Center(child: Container( width: 50 , height: 50 , child: CircularProgressIndicator()))),
        bottomSheet: Container(
                  height: 140,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).primaryColor,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "SUBOTAL",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    '${order.subtotal}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      Container(
                         color: Color(0xff303030),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "TOTAL",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    '${order.total}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),

                    ],
                  )

                  // floatingActionButton: new FloatingActionButton(
                  //   onPressed: () => _tabController
                  //       .animateTo((_tabController.index + 1) % 2), // Switch tabs
                  //   child: new Icon(Icons.swap_horiz),
                  // ),
                  ),


      ),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:readerscorner/models/User.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class ConfirmTab extends StatefulWidget {
  @override
  ConfirmTabState createState() => ConfirmTabState();
}

class ConfirmTabState extends State<ConfirmTab> {
  
  

  Widget generateCart(item, model, context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
          ),
          child: Row(children: <Widget>[
            Container(
                color: Color.fromARGB(255, 230, 230, 230),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 140.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5.0)
                      ],
                      image: DecorationImage(
                          image: NetworkImage(
                            item.image,
                          ),
                          fit: BoxFit.fill)),
                )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.name,
                          overflow:  TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
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
                                            )),
                                        TextSpan(
                                            text: item.qty,
                                            style: TextStyle(
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
          ])),
    );
  }


final Map<String, dynamic> _formData = {
    "gateway": "visa",
    "address_id": 1,
    "discount" : 0,
  };
  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) {
        model.fetchCart();
        model.getUser();
        model.fetchAddresses();
        print(model.cart);
        // model.fetchProducts();
      },
      builder: (context, child, model) => Scaffold(
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 0),
              child: CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        Text("Name", style: TextStyle(color: Colors.black54)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30,
                      top: 20,
                      bottom: 30,
                      right: 25,
                    ),
                    child: model.user!= null?  Text(
                      model.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ) : Text(''),
                  ),
                ])),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        Text("Phone", style: TextStyle(color: Colors.black54)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30,
                      top: 20,
                      bottom: 30,
                      right: 25,
                    ),
                    child: Text(
                      model.user.phone,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ])),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Payment method",
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30,
                      top: 20,
                      bottom: 30,
                      right: 25,
                    ),
                    child: Text(
                      model.user.phone,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                  )
                ])),
                SliverList(
                    delegate: SliverChildListDelegate(model.cart
                        .map((item) => generateCart(item, model, context))
                        .toList())),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    color: Colors.orange,
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
                                '${model.total}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ),
                  Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: (){
                        // model.checkout(_formData , context);
                      },
                                          child: Center(
                          child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  )
                ]))

                // ListView(
                //   shrinkWrap: true,
                //   children: model.cart.map((item) => generateCart(item, model, context))
                //     .toList()
                // ),

                // Container(
                //   color: Colors.orange,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.symmetric(vertical: 20),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 25),
                //           child: Text(
                //             "TOTAL",
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ),
                //         Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 25),
                //             child: Text(
                //              '${model.total}',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             )),
                //       ]),
                // ),
                // Container(
                //   color: Colors.black,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.symmetric(vertical: 20),
                //   child: Center(
                //       child: Text(
                //     "Confirm",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold, color: Colors.white),
                //   )),
                // )
              ]))),
    );
  }
}

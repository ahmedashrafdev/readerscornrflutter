import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/confirm.dart';
import 'package:readerscorner/ui/widgets/rating_bar.dart';
import 'package:readerscorner/ui/widgets/shipping.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/ui/screens/editadd_address.dart';

class ConfirmScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  ConfirmScreen({Key key, @required this.formData}) : super(key: key);
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState(formData);
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final Map<String, dynamic> formData;
  _ConfirmScreenState(this.formData); //constr
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Shipping'),
    new Tab(text: 'Confirm'),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String code;
  bool isCoupon = true;
  @override
  void initState() {
    super.initState();
  }

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
                          overflow: TextOverflow.ellipsis,
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
          ])),
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

  Widget _buildCouponTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 20,
        bottom: 40,
        right: 25,
      ),
      child: TextField(
        decoration: InputDecoration(labelText: 'Coupon'),
       
        onChanged: (String value) {
          code = value;
          print(code);
        },
      ),
    );
  }

  Widget _buildBtn(model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
          elevation: 0.0,
          child: RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print('s');
             model.getCoupon(code , context);
            
              
            },
          )),
    );
  }



  List<Widget> _buildAddresses(context, model) {
    List<Widget> widgets = [];

    Widget tabs = Container(
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.only(bottom: 10),
        color: Color(0xff303030),
        child: Row(children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                  child: Icon(Icons.check_circle_outline, color: Colors.white)),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white)),

                // color: Colors.red,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Center(
                child: Text('CONFIRM',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor
                // color: Colors.red,
                ),
          )
        ]));

    widgets.add(tabs);

    widgets.add(_buildHeader('DELIVERY'));
    widgets.add(_buildContent(model.address['full_address']));
    widgets.add(Divider());
    widgets.add(_buildHeader('PAYMENT'));
    widgets.add(_buildContent(formData['gateway']));
    widgets.add(Divider());

    widgets.add(_buildHeader('SHIPPING'));
    widgets
        .add(_buildContent('EGP' + model.address['shipping_fees'].toString()));
    widgets.add(Divider());

    widgets.add(_buildCouponTextField());
    widgets.add(_buildBtn(model));
    widgets.add(Divider());
    for (var i = 0; i < model.cart.length; i++) {
      widgets.add(generateCart(model.cart[i], model, context));
      // widgets.add(buildAddress(context, model, i));
    }

    // widgets.add(_buildMethodTextField(model));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) {
          model.fetchCart();
          model.getUser();
          model.fetchFullAddress(widget.formData['address_id']);

          print(model.address);
          // model.fetchProducts();
        },
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('Checkout'),
                centerTitle: true,
              ),

              body: Padding(
                padding: model.coupon ==null ? EdgeInsets.only(bottom: 120) : EdgeInsets.only(bottom: 180),
                child: ListView(
                  children: _buildAddresses(context, model),
                ),
              ),
              bottomSheet: Container(
                  height: model.coupon ==null ? 120 : 180,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      model.coupon != null ? Container(
                        color: Theme.of(context).accentColor,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: GestureDetector(
                                  onTap: (){
                                    model.removeCoupon();
                                    setState(() {
                                      isCoupon = false;
                                    });
                                  },
                                                                  child: Text(
                                    "DISCOUNT(remove)",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: model.coupon.type == 'percent' ? Text(
                                    // model.total.toString(),
                                    'EGP${model.coupon.value * model.total / 100}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                  ): Text(
                                    // model.total.toString(),
                                    'EGP${model.coupon.value}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                  )),
                            ]),
                      ) :Container(height: 0,),
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
                                  "TOTAL",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: model.coupon == null ? Text(
                                    // model.total.toString(),
                                    'EGP${model.total + model.address['shipping_fees'].toDouble()}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , color:Colors.white),
                                  ) : model.coupon.type == 'percent' ? 
                                  Text(
                                    // model.total.toString(),
                                    'EGP${model.total + model.address['shipping_fees'].toDouble() - (model.coupon.value * model.total / 100)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , color:Colors.white),
                                  ): Text(
                                    // model.total.toString(),
                                    'EGP${model.total + model.address['shipping_fees'].toDouble() - model.coupon.value}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold , color:Colors.white),
                                  )),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xff303030),
                        child: RaisedButton(
                            color: Color(0xff303030),
                            child: Text('Confirm',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              model.checkout(model.coupon,formData, context);
                            }),
                      ),
                    ],
                  )

                  // floatingActionButton: new FloatingActionButton(
                  //   onPressed: () => _tabController
                  //       .animateTo((_tabController.index + 1) % 2), // Switch tabs
                  //   child: new Icon(Icons.swap_horiz),
                  // ),
                  ),
            ));
  }
}

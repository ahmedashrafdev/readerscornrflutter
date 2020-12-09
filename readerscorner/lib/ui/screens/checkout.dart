import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/confirm.dart';
import 'package:readerscorner/ui/widgets/confirm.dart';
import 'package:readerscorner/ui/widgets/shipping.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/ui/screens/editadd_address.dart';

class ChecoutScreen extends StatefulWidget {
  @override
  _ChecoutScreenState createState() => _ChecoutScreenState();
}

class _ChecoutScreenState extends State<ChecoutScreen> {
  final Map<String, dynamic> _formData = {
    "gateway": "",
    "address_id": "",
    "discount_code": "",
  };
  @override
  void initState() {
    super.initState();
  }

  Widget buildAddress(BuildContext context, MainModel model, int index) {
    Address address = model.addresses[index];
    bool checked = _formData['address_id'] == address.id;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: GestureDetector(
        onTap: (() {
          setState(() {
            _formData['address_id'] =
                _formData['address_id'] == address.id ? null : address.id;
          });
          print(_formData['address_id']);
        }),
        child: Card(
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        // color: Colors.red,
                      ),
                      child: checked
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: Icon(
                                Icons.check,
                                size: 15,
                              ))
                          : Text(''))),
              Expanded(
                child: Container(
                    width: double.infinity,
                    child: GFAccordion(
                      expandedTitlebackgroundColor: Colors.white,
                      titleChild: Text('${address.title}'),
                      contentChild: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'phone :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.phone}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'city :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.city_name}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'Building :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.building}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'Postal :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.postal}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'Street :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.street}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'Apartment :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.apartment}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                text: 'Floor :',
                                style: TextStyle(
                                    color: Color(0xff626262), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${address.floor}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff383838))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodTextField(model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: DropDownFormField(
        titleText: 'payment method',
        hintText: 'Please choose one',
        value: _formData['gateway'],
        validator: (value) {
          // if (value.trim().length <= 0) {
          if (value == null) {
            return 'Payment method is required.';
          }
        },
        onChanged: (value) {
          setState(() {
          _formData['gateway'] = value;    
          });
        },
        dataSource: [
          {
            "display": 'Cash on delivery',
            "value": 'cashOnDelivery',
          },
          {
            "display": 'Credit card',
            "value": 'visa',
          }
        ],
        textField: 'display',
        valueField: 'value',
      ),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Center(
                child: Text('SHIPPING',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white)),
                color: Theme.of(context).primaryColor
                // color: Colors.red,
                ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Center(
                child: Text('CONFIRM',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            decoration: BoxDecoration(
             
              // color: Colors.red,
            ),
          )
        ]));

    
    widgets.add(tabs);
    for (var i = 0; i < model.addresses.length; i++) {
      widgets.add(buildAddress(context, model, i));
    }

    widgets.add(_buildMethodTextField(model));

    return widgets;
  }

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
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('Checkout'),
                centerTitle: true,
              ),
              body: ListView(
                children: _buildAddresses(context, model),
              ),
              bottomSheet: Container(
                  height: 120,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('Add Address'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (BuildContext context) =>
                                    EditAddAddress(Address()),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text('Continue'),
                            onPressed: () {
                              if(_formData['gateway'] == null || _formData['address_id'] == null){
                                  model.showFlushBar(context, 'Please choose your data');
                                }else{
                                   setState(() {
                                
                                
                                
                                print(_formData);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (BuildContext context) =>
                                        ConfirmScreen(formData: _formData,)
                                  ),
                                );
                              });
                                }
                             
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

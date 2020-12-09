import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/models/Filter.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/ui/screens/editadd_address.dart';

class ShippingTab extends StatefulWidget {
  @override
  ShippingTabState createState() => ShippingTabState();
}

class ShippingTabState extends State<ShippingTab> {
  final Map<String, dynamic> _formData = {
    "gateway": "",
    "address_id": "",
    "discount": 0,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BuildContext context;

  Widget buildAddress(BuildContext context, MainModel model, int index) {
    Address address = model.addresses[index];
    bool checked = _formData['address_id'] == address.id; 

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: GestureDetector(
          onTap: ((){
                setState(() {
                   _formData['address_id'] = _formData['address_id'] == address.id ? null : address.id;
                  
                });
                print( _formData['address_id']);
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
                      child:checked ? Padding( padding: EdgeInsets.only(bottom:0) ,child: Icon(Icons.check , size: 15,)): Text('')
                      
                    )),
              
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
        validator: (value) {
          // if (value.trim().length <= 0) {
          if (value == null) {
            return 'Payment method is required.';
          }
        },
        onChanged: (value) {
          _formData['method'] = value;
        },
        dataSource: [
          {
            "display": 'Cash on deliver',
            "value": 'cashOnDelivery',
          },
          {
            "display": 'Credit cart',
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
    for (var i = 0; i < model.addresses.length; i++) {
      widgets.add(buildAddress(context, model, i ));
    }

   
    widgets.add(_buildMethodTextField(model));
   
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) => model.fetchAddresses(),
      builder: (context, child, model) => Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: _buildAddresses(context, model),
          ),
        ),
      ),
    );
  }
}

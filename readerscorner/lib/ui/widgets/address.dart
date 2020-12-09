import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/screens/editadd_address.dart';

Widget buildAddress(BuildContext context , MainModel model , int index) {
    Address address = model.addresses[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical:7 , horizontal: 10),
      
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                child: GFAccordion(
                  expandedTitlebackgroundColor : Colors.white,
                  titleChild:Text('${address.title}') ,
                  contentChild: Column(
                    children: <Widget>[
                     
                      Container(
                        
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'phone :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.phone}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'city :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.city_name}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'Building :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.building}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'Postal :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.postal}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'Street :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.street}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'Apartment :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.apartment}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            text: 'Floor :',
                            style:
                                TextStyle(color: Color(0xff626262), fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${address.floor}',
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff383838))),
                            ],
                          ),
                        ),
                      ),
                      Row(
              children: <Widget>[
                new RaisedButton(
                    color: Color(0xffF04141),
                    onPressed: () {
                      model.removeAddress(address.id, context);
                      model.addresses.remove(address);
                    },
                    child: Center(
                          child: Text("Remove",
                              style: TextStyle(fontSize: 16 ,color: Colors.white))),
                    ),
                  
                SizedBox(width: 10,),
                RaisedButton(
                    color: Color(0xff3881FF),
                    
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => EditAddAddress(address),
                            ),
                          );
                    },
                    child: Center(
                          child: Text("Edit",
                              style: TextStyle(fontSize: 16 ,color: Colors.white))),
                    ),
                  
                
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
                    ],
                  ),
                )),
            
          ],
        ),
      ),
    );
  }

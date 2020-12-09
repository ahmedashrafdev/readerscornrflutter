import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readerscorner/models/Coupon.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:flutter/material.dart';


class CouponModel extends Model {
 Coupon _coupon;
 double _discount;
 Coupon get coupon => _coupon;

void removeCoupon(){
  _coupon = null;
}
Future getCoupon(code , context) async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.get(
      Settings.MY_SERVER_URL+'coupon/${code}',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((http.Response response) async {
      var res = json.decode(response.body);
      if(res.containsKey('error')){
        showFlushBar(context , 'Coupon not found');
      }else{
           _coupon = Coupon.fromJson(res);
            print(coupon.type);
      }
    
  
      notifyListeners();
    });

  }

  void showFlushBar(BuildContext context , String msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

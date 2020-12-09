import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/order_complete.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:readerscorner/utils/constants.dart';
import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutModel extends Model {
  void showCheckoutFlushBar(BuildContext context, String msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  Future checkout(coupon,formData, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if(coupon!= null){
      formData['discount_code'] = coupon.code;
    }
    print(formData);
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL + 'checkout',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('success')) {
          if (responseData['success'] == false) {
            String responseMsg = responseData['message'];
            showCheckoutFlushBar(context, responseMsg);
          } else {
            if (responseData.containsKey('url')) {
              launch(responseData['url']);
            } else {
              String responseMsg = responseData['message'];
              showCheckoutFlushBar(context, responseMsg);
              Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => OrderCompleteScreen(),
            ),
          );
              // Navigator.pushReplacementNamed(context, 'home');
            }
          }
        }

        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showCheckoutFlushBar(context, responseMsg);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    
    notifyListeners();
  }
}

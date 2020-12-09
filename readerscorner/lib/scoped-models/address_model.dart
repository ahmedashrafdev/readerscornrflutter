import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readerscorner/models/Address.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/addresses.dart';

class AddressModel extends Model {
  List<Address> _addresses = [];
  var address;
  List<Address> get addresses => List.from(_addresses);
  void fetchAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.get(
      Settings.MY_SERVER_URL+'user/addresses',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      _addresses = await parseAdresses(response.body);
      notifyListeners();
    }}catch(e){
      throw Exception(e.toString());

    };
  }


void fetchFullAddress(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.get(
      Settings.MY_SERVER_URL+'address/${id}',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    
    if (response.statusCode == 200) {
      address = json.decode(response.body)[0];
      print(address);
      notifyListeners();
    }}catch(e){
      throw Exception(e.toString());

    };
  }

  static List<Address> parseAdresses(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }
  Future removeAddress(id,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.delete(
        Settings.MY_SERVER_URL+'user/addresses/${id}/delete',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        String responseMsg = "Address deleted Successfully";
        showFlushBar(context , responseMsg);
         fetchAddresses();
        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showFlushBar(context , responseMsg);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
  }

  
  Future addAddress(formData,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'user/address/add',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
     
      if (response.statusCode == 200) {
        String responseMsg = "Address Added Successfully";
        showFlushBar(context , responseMsg);
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => AddressesScreen(),
            ),
          );

        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showFlushBar(context , responseMsg);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  Future editAddress(id,formData,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.put(
        Settings.MY_SERVER_URL+'user/addresses/${id}/update',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => AddressesScreen(),
            ),
          );

          String responseMsg = "Address Updated Successfully";
        showFlushBar(context , responseMsg);

        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showFlushBar(context , responseMsg);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }


  void showFlushBar(BuildContext context , String msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

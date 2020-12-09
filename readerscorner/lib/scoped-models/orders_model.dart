import 'dart:convert';

import 'package:readerscorner/models/User.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
class OrderModel extends Model {
   User user ;
  void getUserOrders() async{
    // final response = await http.get(
    //     Settings.MY_SERVER_URL+'user',

    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token',
    //     },
    //   );
      
    //  if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //     user = User(
    //       id: responseData['id'] ,
    //       name: responseData['name'] ,
    //       email: responseData['email'],
    //       password: responseData['password'],
    //       city_id: responseData['city_id'],
    //       phone: responseData['phone'],
    //       token: responseData['token'],
    //     );
    //     // fetchAddresses();
    //     notifyListeners();
    //   }
  }

  
}
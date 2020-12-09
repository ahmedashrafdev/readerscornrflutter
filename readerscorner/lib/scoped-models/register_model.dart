import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/models/User.dart';
import 'package:readerscorner/models/City.dart';
import 'package:readerscorner/services/storage_service.dart';
import 'package:readerscorner/utils/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:flushbar/flushbar.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegisterModel extends Model {
  StorageService storageService = getIt.get<StorageService>();
  String responseMsg;
  List<City> _cities = [];
  City _city ;
  List<City> get cities => List.from(_cities);
  City get city => _city;
  List<Address> addresses = [] ;
  // List<Address> get addresses => List.from(_addresses);
  User user ;
  
  void showSimpleFlushBar(BuildContext context) {
    Flushbar(
      message: responseMsg,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void autoAuthenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null){
      getUser(token);
    }
  }

  void getUser(token) async{
    final response = await http.get(
        Settings.MY_SERVER_URL+'user',

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
     if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        user = User(
          id: responseData['id'] ,
          name: responseData['name'] ,
          email: responseData['email'],
          password: responseData['password'],
          city_id: responseData['city_id'],
          phone: responseData['phone'],
          token: responseData['token'],
        );
        fetchAddresses();
        notifyListeners();
      }
  }
  void fetchCities() {
    http
        .get(Settings.MY_SERVER_URL+'cities')
        .then((http.Response response) {
      _cities = parseCities(response.body);
      print(cities);
      print(cities);
      notifyListeners();
    });
  }
  void fetchAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String  token =  prefs.getString('token');
    final response = await http.get(
        Settings.MY_SERVER_URL+'user/addresses',

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    var parsed=json.decode(response.body) as List;
      // parsed.forEach((element) {
      //   var map = element as Map;
      //   addresses.add(Address.fromMap(map))
      // });
      parsed.forEach(
        (address) {
          addresses.add(Address(
            id : address.id,
            phone : address.phone,
            title : address.title,
            building : address.building,
            postal : address.postal,
            apartment : address.apartment,
            city_id : address.city_id,
            street : address.street,
            floor : address.floor,
          ));
          // print(address);
          // return {
          //   "id" : address.id,
          //   "phone" : address.phone,
          //   "title" : address.title,
          //   "building" : address.building,
          //   "postal" : address.postal,
          //   "apartment" : address.apartment,
          //   "city_id" : address.city_id,
          //   "street" : address.street,
          //   "floor" : address.floor,
          // };
        },
      );
     
      print("m");
      print(addresses);
      print(response.body);
      notifyListeners();
    
  }

  void fetchCity() {
    http
        .get(Settings.MY_SERVER_URL+'cities')
        .then((http.Response response) {
      _cities = parseCities(response.body);
      print(cities);
      notifyListeners();
    });
  }

  static List<City> parseCities(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
  }

  

  Future register(formData, context) async {
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'register',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        responseMsg = "registred successfuly pleas login to continue";
        showSimpleFlushBar(context);
        Navigator.pushReplacementNamed(context, 'signin');
        // setState(ViewState.Loaded);

      } else {
        responseMsg = "somthing went wrong pleas try again";
        showSimpleFlushBar(context);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }


  
  Future login(formData, context) async {
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'login',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      print('login');
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool hasError = true;
        String message= "somthing went wrong pleas try again";
        if(responseData.containsKey('access_token')){
          hasError = false;
          message = 'Authintication succeed';
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = responseData['access_token'];
          prefs.setString('token' , token);
          getUser(token);
        Navigator.pushReplacementNamed(context, 'home');
        }
        // response.body
        // setState(ViewState.Loaded);

      } else {
        responseMsg = "somthing went wrong pleas try again";
        showSimpleFlushBar(context);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }
  
}

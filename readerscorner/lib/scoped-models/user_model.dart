import 'dart:convert';
import 'package:readerscorner/models/Order.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/models/User.dart';
import 'package:readerscorner/ui/screens/home.dart';
import 'package:readerscorner/ui/screens/login.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:readerscorner/models/City.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class UserModel extends Model {
  User user;
  String points;
  int selectedOrder;
  List<City> _cities = [];
  List<City> get cities => List.from(_cities);
  List<Order> _orders = [];
  List<Order> get orders => List.from(_orders);
  String responseMsg;
  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;
  bool pointsLoading = false;
List<Product> _orderProducts = [];
 
  List<Product> get orderProducts => List.from(_orderProducts);
  void autoAuthenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      await getUser();
    }
    notifyListeners();
  }

  void getUser() async {
    _isUserLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(
      Settings.MY_SERVER_URL + 'user',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      user = await User(
        id: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        password: responseData['password'],
        city_id: responseData['city_id'],
        phone: responseData['phone'],
        token: responseData['token'],
      );
      // print(user);
      // fetchAddresses();
    }
    _isUserLoading = false;

    notifyListeners();
  }


  Future fetchPoints() async {
    pointsLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(
      Settings.MY_SERVER_URL+'user/points',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  // print(json.decode(response.body)[0]['points']);
    if (response.statusCode == 200) {
      points = json.decode(response.body)[0]['points'].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('points', points);
    }
    
       pointsLoading = false;
      
      notifyListeners();
 
  }

  void fetchOrderDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(
      Settings.MY_SERVER_URL+'order/${selectedOrder}',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
    _orderProducts = await parseProducts(response.body);
   
       
      // points = json.decode(response.body)[0]['points'].toString();
      //  print(json.decode(response.body)['points']);
    }
    
      
      notifyListeners();
 
  }

void fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(
      Settings.MY_SERVER_URL+'user/orders',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  
    if (response.statusCode == 200) {
       _orders = parseOrders(response.body);
       
      // points = json.decode(response.body)[0]['points'].toString();
      //  print(json.decode(response.body)['points']);
    }
    
      
      notifyListeners();
 
  }


  Future login(formData, context) async {
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL + 'login',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool hasError = true;
        String message = "somthing went wrong pleas try again";
        if (responseData.containsKey('access_token')) {
          hasError = false;
          message = 'Authintication succeed';
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = responseData['access_token'];
          String name =formData['name'];
          String email = formData['email'];

          await prefs.setString('token', token);
          await prefs.setString('name', name);
          await prefs.setString('email', email);
          await getUser();
         
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => HomeScreen()));
        }else{
          message = responseData['message'];
           showSimpleFlushBar(context, message);
        }
        // response.body
        // setState(ViewState.Loaded);

      } else {
        String message = "somthing went wrong pleas try again";
        showSimpleFlushBar(context, message);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  Future register(formData, context) async {
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL + 'register',
        body: jsonEncode(formData),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        responseMsg = "registred successfuly pleas login to continue";
        showSimpleFlushBar(context, responseMsg);
        Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => LoginScreen()));
        // setState(ViewState.Loaded);

      } else {
        responseMsg = "somthing went wrong pleas try again";
        showSimpleFlushBar(context, responseMsg);

        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  void showSimpleFlushBar(BuildContext context, String msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void fetchCities() {
    http.get(
      Settings.MY_SERVER_URL + 'cities',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    ).then((http.Response response) {

      _cities = parseCities(response.body);
      notifyListeners();
    });
  }

  static List<City> parseCities(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
  }

  static List<Order> parseOrders(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Order>((json) => Order.fromJson(json)).toList();
  }

  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}

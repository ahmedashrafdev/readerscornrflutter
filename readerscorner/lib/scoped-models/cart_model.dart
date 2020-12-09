import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:readerscorner/models/Cart.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends Model {
  List<Product> _cart = [];
  List<Product> _wishlist = [];
  bool cartLoading = false;
  List<Product> get cart => List.from(_cart);
  int get totalQty => cart.length;
  double get total =>_cart.map<double>((m) => m.price).reduce((a,b )=>a+b);
  List<Product> get wishlist => List.from(_wishlist);
  void fetchCart() async {
    cartLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.get(
      Settings.MY_SERVER_URL+'cart/',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((http.Response response) async {
      _cart = await parseProduct(response.body);
       //total =_cart.map<double>((m) => m.price).reduce((a,b )=>a+b);
       cartLoading = false;
      print(_cart);
      notifyListeners();
    });
    
  }


  // void fetchCartCount() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   http.get(
  //     Settings.MY_SERVER_URL+'cart/count',
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   ).then((http.Response response) async {
  //     var res = json.decode(response.body);
  //     totalQty = res;
  //     notifyListeners();
  //   });
  // }

  

void fetchWishlist() async {
   cartLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.get(
      Settings.MY_SERVER_URL+'cart/wishlist',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((http.Response response) async {
      _wishlist = await parseProduct(response.body);
      cartLoading = false;
      notifyListeners();
    });

  }

  Future addToCart(data,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'cart/add',
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {

      print(response.body);
        String responseMsg = "Item added to cart successfully";
        showFlushBar(context , responseMsg);
      await fetchCart();
        print('ss');
        print(totalQty);

        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showFlushBar(context , responseMsg);
         await fetchCart();
    // setState(ViewState.Loaded);
    notifyListeners();
        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  Future addToWishlist(data,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'cart/add/wishlist',
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {

      print(response.body);
        String responseMsg = "Item added to wishlist successfully";
        showFlushBar(context , responseMsg);

        // setState(ViewState.Loaded);

      } else {
        String responseMsg = "somthing went wrong pleas try again";
        showFlushBar(context , responseMsg);
         await fetchCart();
    // setState(ViewState.Loaded);
    notifyListeners();
        // setState(ViewState.Loaded);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  Future decreaseQty(id,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.post(
        Settings.MY_SERVER_URL+'cart/decrease/${id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
 await fetchCart();
    // setState(ViewState.Loaded);
    notifyListeners();
      
    } catch (e) {
      throw Exception(e.toString());
    }
    // setState(ViewState.Loaded);
    notifyListeners();
  }

  Future deleteItem(id,  context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      final response = await http.delete(
        Settings.MY_SERVER_URL+'cart/remove/${id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      await fetchCart();
      
    } catch (e) {
      throw Exception(e.toString());
    }
   
  }
  void showFlushBar(BuildContext context , String msg) {
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  static List<Product> parseProduct(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
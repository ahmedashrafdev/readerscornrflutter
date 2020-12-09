import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:readerscorner/enums/view_states.dart';
import 'package:readerscorner/models/Filter.dart';
import 'package:readerscorner/scoped-models/base_model.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:readerscorner/utils/constants.dart';
import 'package:readerscorner/models/Product.dart';
class ProductModel extends BaseModel {
  int offset = 0;
  int limit= 10;
  bool hasChildren = true;
  String search = '';
  String category = '';
  String author = '';
  String language = '';
  String age = '';
  String key = '';
  String selectedProduct;
  Product product ;
  bool isProductsLoading = false;
  bool isProductLoading = false;
  List<Product> _products = [];
  List<Product> _bestsellers = [];
  List<Product> _populars = [];
  List<dynamic> categoryData =[];
  List<Product> get products => List.from(_products);
  List<Product> get bestsellers => List.from(_bestsellers);
  List<Product> get populars => List.from(_populars);

  List<Filter> _categories = [];
  List<Filter> get categories => List.from(_categories);


  List<Filter> _authors = [];
  List<Filter> get authors => List.from(_authors);
  List<Filter> _ages = [];
  List<Filter> get ages => List.from(_ages);

  List<Filter> _languages = [];
  List<Filter> get languages => List.from(_languages);
  
  void fetchCategories(category) async{
    String url = Settings.MY_SERVER_URL+'categories/'+category;
    final response = await http.get(
        url,

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ); 
      if (response.statusCode == 200) {
        if(category == ""){
        _categories = await parseFilter(response.body);
        }else{
          if(jsonDecode(response.body).length > 0){
            categoryData = jsonDecode(response.body);
          }else{
            hasChildren = false;
            // categoryData = jsonDecode(response.body);
            // print('false');

          }
          
        }
      
      notifyListeners();
         notifyListeners();
      }else{

      }
     
  }

  void fetchAuthors(){
     http.get(
      Settings.MY_SERVER_URL+'authors',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((http.Response response) async {
      _authors = await parseFilter(response.body);
      
      notifyListeners();
    });
  }

  void fetchLnaguages(){
     http.get(
      Settings.MY_SERVER_URL+'languages',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((http.Response response) async {
      _languages = await parseFilter(response.body);
      
      notifyListeners();
    });
  }

  void fetchAges(){
     http.get(
      Settings.MY_SERVER_URL+'ages',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((http.Response response) async {
      _ages = await parseFilter(response.body);
      
      notifyListeners();
    });
  }

  void fetchProducts() async {
  
    isProductsLoading  =true;
    notifyListeners();
    Map<String,String> queryParameters ={
       "offset" : offset.toString(),
      "limit" : limit.toString(),
    };
  
    search != "" ? queryParameters['search'] = search : "";
    category != "" ? queryParameters['category'] = category : "";
    author != "" ? queryParameters['search'] = search : "";
    language != "" ? queryParameters['language'] = search : "";
    age != "" ? queryParameters['age'] = search : "";
    author != "" ? queryParameters['author'] = search : "";
   
    var uri =Uri.http(Settings.MY_SERVER_IP, 'public/api/product', queryParameters);
   await  http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      
    ).then((http.Response response) async {
      _products = await List.from(_products)..addAll(parseProducts(response.body));
    
    
      
    });
        

      notifyListeners();
  }

  void fetchBestsellers() async {
    
    Map<String,String> queryParameters = {
      
      "key" : "bestsellers",
    };
    var uri =Uri.http(Settings.MY_SERVER_IP, '/api/product', queryParameters);
    http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      
    ).then((http.Response response) async {
      _bestsellers = await parseProducts(response.body);
    });
      notifyListeners();
  }

  void fetchPopulars() async {
    
    Map<String,String> queryParameters = {
      
      "key" : "popular",
    };
    var uri =Uri.http(Settings.MY_SERVER_IP, '/api/product', queryParameters);
    http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      
    ).then((http.Response response) async {
      _populars = await parseProducts(response.body);
    });
      notifyListeners();
  }
  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

   static List<Filter> parseFilter(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Filter>((json) => Filter.fromJson(json)).toList();
  }

  void fetchProduct(context) async{
   isProductLoading = true;

    final response = await http.get(
        Settings.MY_SERVER_URL+'product/${selectedProduct}',

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );      
      
     if (response.statusCode == 200) {
       
         var producttt = jsonDecode(response.body);
   
        product = await Product(
          id: producttt[0]['id'],
          name: producttt[0]['name'],
          isbn: producttt[0]['isbn'],
          slug: producttt[0]['slug'],
          price: producttt[0]['price'].toDouble(),
          image: producttt[0]['image'],
          author_name: producttt[0]['author_name'],
          description: producttt[0]['description'],
          details: producttt[0]['details'],
          avg_rate: producttt[0]['avg_rate'],
          );
          
          // await Future.delayed(Duration(seconds: 4));
          
   isProductLoading = false;

      notifyListeners();

        //   slug: producttt[0]['slug'],
        //   image: producttt[0]['image'],
        //   author_name: producttt[0]['author_name'],
        //   avg_rate: producttt[0]['avg_rate'],
        //   description: producttt[0]['description'],
        //   details: producttt[0]['details'],
        //   order_limit: producttt[0]['order_limit'],
        // );
        
      }

  }
  
}

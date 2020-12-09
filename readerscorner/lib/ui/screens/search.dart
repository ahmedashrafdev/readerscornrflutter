import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/ui/partials/search_product.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class DataSearch extends SearchDelegate<String> {
  List<Product> list = [];

  List<Product> search(query) {
    Map<String, String> queryParameters = {
      "offset": '0',
      "limit": '10',
      "search": query,
    };
    var uri = Uri.http(Settings.MY_SERVER_IP, '/api/product', queryParameters);
    http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    ).then((http.Response response) async {
      List<Product> result = await parseProducts(response.body);
      list = result;
      return result;
    });
  }

  final recent = ['asdas', 'ym'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestionList = query.isEmpty ? recent : search(query);
    // print(list);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Product product = list[index];

          return GestureDetector(
            onTap: () => {
              Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => ProductScreen(
                curProduct: product,
              ),
            ),
          )
            },
                      child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: FadeInImage(
                      // image: NetworkImage(product.image),
                      image: NetworkImage(product.image),
                      placeholder: AssetImage('images/no-product-image.png'),
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 120,
                   
                    child: Text(
                      product.name,
                      softWrap: true,
                      // product.name,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),

                  SizedBox(width: 10),
                  Container(
                
                  child: Text(
                    'EGP${product.price}',
                    // 'EGP${product.price}',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                )
                ],
              ),
            ),
          );
        });
    // return Text('as');
    // ListView.builder(
    //   itemBuilder: (context , index) =>ListTile(
    //     onTap: (){

    //     },
    //     leading: Icon(Icons.book),
    //     title: RichText(text: TextSpan(text:suggestionList[index]))
    //   ),
    //   itemCount: suggestionList.length,
    // );
  }
}

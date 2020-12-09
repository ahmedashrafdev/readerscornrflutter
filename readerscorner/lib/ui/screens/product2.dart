import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/partials/product.dart';
import 'package:readerscorner/ui/widgets/loader.dart';

import 'package:carousel_pro/carousel_pro.dart';

class ProductScreenTwo extends StatelessWidget {
  final Product curProduct;
  ProductScreenTwo({this.curProduct});
  Size _deviceSize;
  Widget _buildProductsCarousel() {}
  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), title: Text("Search")),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Cart")),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text("My Account")),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Align(
      heightFactor: 0.35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductDetailsTop(
      BuildContext context, Product product, MainModel model) {
    return Container(
      margin: EdgeInsets.only(top: 70.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0))
                    ]),
                    child: Text('as'),
                    // child: Image(
                    //   width: 150.0,
                    //   height: 180.0,
                    //   image: NetworkImage(product.image),
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'name',
                        // product.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                        text: TextSpan(text: 'Author'),
                        // text: TextSpan(text: 'Author : ${product.author_name}'),
                      ),
                      RichText(
                        text: TextSpan(text: 'Code :'),
                        // text: TextSpan(text: 'Code :${product.isbn}'),
                      )
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                      child: RaisedButton(
                        onPressed: () {
                          final Map<String, dynamic> _data = {
                            "product": product.id,
                            "qunatinty": "1"
                          };
                          if (product.order_limit > 0) {
                            model.addToCart(_data, context);
                            model.showFlushBar(
                                context, "Item added successfully");
                          } else {
                            model.showFlushBar(
                                context, "Sorry item is not avilable");
                          }
                        },
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        child: Text('Add To Cart'),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  Text('EGP123',
                      // Text('\$ ${product.price}',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12,
                              offset: Offset(0.0, 10.0))
                        ]),
                    child: Icon(
                      Icons.favorite_border,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Widget _buildProductTop(
      BuildContext context, Product product, MainModel model) {
    return Container(
      height: 320.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.orange),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            heightFactor: 3.5,
            child: _buildProductDetailsTop(context, product, model),
          ),
          _buildAppBar(context)
        ],
      ),
    );
  }

  Widget appCarousel() {
    return Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        autoplayDuration: Duration(seconds: 100),
        dotBgColor: Colors.transparent,
        images: [
          NetworkImage(
              'https://readerscorner.co/public/storage/mobileapplicaion/assets/c1.png'),
          NetworkImage(
              'https://readerscorner.co/public/storage/mobileapplicaion/assets/c2.png'),
          NetworkImage(
              'https://readerscorner.co/public/storage/mobileapplicaion/assets/c3.png'),
        ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
  }

  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) {
        // model.fetchProducts();
        // model.fetchProducts();
      },
      builder: (context, child, model) => Loader(
        show: false,
        child: Scaffold(
            body: Container(
              color: Colors.white,
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                   
                  ClipPath(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(color: Colors.orange),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    heightFactor: 3.5,
                    child: _buildProductDetailsTop(context ,  curProduct , model ),
                  ),
                  _buildAppBar(context)
                    
                  ]),
                ),
                SliverToBoxAdapter(
                  //     child: Stack(
                  //       children: <Widget>[
                  //       ClipPath(
                  //         child: Container(
                  //           height: double.infinity,
                  //           decoration: BoxDecoration(color: Colors.orange),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: FractionalOffset.center,
                  //         heightFactor: 3.5,
                  //         child: _buildProductDetailsTop(context ,  curProduct , model ),
                  //       ),
                  //     _buildAppBar(context)
                  //   ],
                  // )
                ),
                // SliverList(
                //   delegate: SliverChildListDelegate([
                //     Container(
                //       color: Colors.white,
                //       child: Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: Row(
                //           children: <Widget>[
                //             Icon(
                //               Icons.category,
                //               color: Colors.blue,
                //             ),
                //             SizedBox(
                //               width: 8.0,
                //             ),
                //             Text('bestsellers',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.normal,
                //                 )),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ]),
                // ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     color: Colors.white,
                //     height: 310,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: model.products.length,
                //       itemBuilder: (context, index) {
                //         return productPartial(
                //             index, model.products, _deviceSize, context);
                //       },
                //     ),
                //   ),
                // ),
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: FadeInImage(
                //       image: NetworkImage(
                //           "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSq8kb30ZeKhdGQLvcD64xQoFFirXa62jWkSsINCiWj5dhJ6V1F&usqp=CAU,"),
                //       placeholder: AssetImage('images/no-product-image.png'),
                //       height: 152,
                //     ),
                //   ),
                // ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     color: Colors.white,
                //     height: 310,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: model.products.length,
                //       itemBuilder: (context, index) {
                //         return productPartial(
                //             index, model.products, _deviceSize, context);
                //       },
                //     ),
                //   ),
                // ),
              ]),
            ),
            bottomNavigationBar: bottomNavigationBar()),
      ),
    );
  }
}

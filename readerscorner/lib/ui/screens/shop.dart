import 'package:flutter/material.dart';
import 'package:readerscorner/enums/view_states.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/partials/product.dart';
import 'package:readerscorner/ui/widgets/appDrawer.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';

import 'package:carousel_pro/carousel_pro.dart';

class ShopScreen extends StatefulWidget {
  final String category;
  final String age;
  final String language;
  final String author;

  ShopScreen(this.category, this.age, this.language, this.author);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  ScrollController _scrollController;
  MainModel modell = new MainModel();
  bool _show;
  List<Product> products;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          modell.fetchProducts();
          modell.notifyListeners();

          List<Product> productss = products..addAll(modell.products);
          setState(() {
            _show = true;
            products = productss;
          });
          print(products);
          print(_show);
        } else {
          _show = false;
          print(_show);
        }
      });
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // it is a good practice to dispose the controller
    super.dispose();
  }

  Size _deviceSize;
  Widget _getBodyUi(ViewState state) {
    switch (state) {
      case ViewState.Loading:
        return CircularProgressIndicator();
      case ViewState.Loaded:
      default:
        return Text('Done');
    }
}  
  Widget _buildProductsCarousel() {}

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 50) / 2;
    final double itemWidth = (size.width / 2)- 10;
    return BaseView<MainModel>(
      onModelReady: (model) async {
        model.author = widget.author;
        model.category = widget.category;
        model.age = widget.age;
        model.language = widget.language;
        model.fetchProducts();
        model.fetchCategories("");
        model.fetchAges();
        model.fetchAuthors();
        await model.fetchCart();
        model.fetchLnaguages();
        model.getUser();
        print(model.products);
        // model.fetchProducts();
      },
      builder: (context, child, model) => Loader(
        show: model.state == ViewState.Loading,
        child: Scaffold(
            appBar: buildAppBar(context, 'shop' , model),
            drawer: AppDrawer(
                categories: model.categories,
                user: model.user,
                languages: model.languages,
                authors: model.authors,
                ages: model.ages),
            body: Container(
              // padding: EdgeInsets.only(bottom: 100),
              child: model.products.length > 0
                  ? CustomScrollView(slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10 , mainAxisSpacing: 10 ,crossAxisCount: 2 ,  childAspectRatio: (itemWidth / itemHeight) ),
                        delegate : SliverChildListDelegate(
                           model.products.map(
                              (product) {
                                return GestureDetector(
                                  child: GridTile(
                                    child:
                                        productPartial(product, size, context),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                      ),
                      
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(padding: EdgeInsets.all(8.0),
                            child: RaisedButton(color:Theme.of(context).primaryColor ,child: Text('Load More' , style:TextStyle(color:Colors.white)),onPressed: (){
                              model.offset = model.offset + 10;
                model.fetchProducts();
                            },),
                          )
                        ]),
                      ),
                    ])
                  : Column(
                      children: <Widget>[
                         Center(child: Container(padding: EdgeInsets.only(top: 200) ,width:50 , height:50,child: CircularProgressIndicator())),
                        // Container(
                        //     padding: EdgeInsets.only(top: 50),
                        //     child: Center(
                        //       child: Text(
                        //           'Sorry !There is no item for your filter '),
                        //     )),
                        // RaisedButton(
                        //   color: Theme.of(context).primaryColor,
                        //   child: Text(
                        //     'Continue Shopping',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         fullscreenDialog: true,
                        //         builder: (BuildContext context) =>
                        //             ShopScreen("", "", "", ""),
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
                    ),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              index: 2,
            )),
      ),
    );
  }
}

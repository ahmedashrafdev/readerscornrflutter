import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/partials/product.dart';
import 'package:readerscorner/ui/widgets/appDrawer.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatelessWidget {
  Size _deviceSize;

  Widget _buildProductsCarousel() {}

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
      onModelReady: (model) async {
        await model.fetchBestsellers();
        await model.fetchPopulars();
        await model.fetchCategories("");
        await model.fetchAges();
        await model.fetchCart();
        await model.fetchAuthors();
        await model.fetchLnaguages();
        await model.getUser();
        print(model.user);
        // model.fetchProducts();
      },
      builder: (context, child, model) => Loader(
        show: false,
        child: Scaffold(
            appBar: buildAppBar(context, 'home' , model),
            drawer: AppDrawer(
                categories: model.categories,
                user: model.user,
                languages: model.languages,
                authors: model.authors,
                ages: model.ages),
            body: Container(
              color: Colors.white,
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                      [Container(child: appCarousel())]),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.high_quality,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Bestsellers',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      color: Colors.white,
                      height: 330,
                      child:  model.populars.length > 0 ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.bestsellers.length,
                        itemBuilder: (context, index) {
                          return productPartial(
                              model.bestsellers[index], _deviceSize, context);
                        },
                      ) :Center(child: Container( width: 50 , height: 50 , child: CircularProgressIndicator())),
                      )
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: FadeInImage(
                        image: NetworkImage(
                            "http://readerscorner.co//storage/banner.jpeg"),
                        placeholder: AssetImage('images/no-product-image.png'),
                        height: 152,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.assessment,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Populars',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    height: 330,
                    child: model.populars.length > 0 ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.populars.length,
                      itemBuilder: (context, index) {
                        return productPartial(
                            model.populars[index], _deviceSize, context);
                      },
                    ):Center(child: Container(width: 100 , height: 100 , child: CircularProgressIndicator())),
                  ),
                ),
              ]),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              index: 0,
            )),
      ),
    );
  }
}

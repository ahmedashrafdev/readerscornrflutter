import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/ui/screens/categories.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/partials/product.dart';
import 'package:readerscorner/ui/screens/product.dart';
import 'package:readerscorner/ui/screens/shop.dart';
import 'package:readerscorner/ui/widgets/appDrawer.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';

class CategoryScreen extends StatefulWidget {
  final String id;
  final String slug;
  final String name;
  CategoryScreen(this.id, this.slug, this.name);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Size _deviceSize;
  bool isLoading = false;
  List<Widget> _buildCarousels(model, context) {
    List<Widget> result = [];

    model.categoryData.forEach((e) {
      print(e);
      // print(model.categoryData[0]['products'][0]['name']);
      result.add(_buildCarousel(e, context));
    });
    return result;
  }

  Widget _buildCarousel(e, context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => CategoryScreen(
                                  e['category']['id'].toString(),
                                  e['category']['slug'],
                                  e['category']['name']),
                            ),
                          );
                        },
                        child: Text(e['category']['name'])),
                  ),
                ),
                Expanded(
                  child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (BuildContext context) => ShopScreen(
                                    e['category']['slug'], '', '', '')),
                          );
                        },
                        child: Text(
                          'VIEW ALL',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      )),
                ),
              ],
            ),
            //   Column(
            //     verticalDirection: VerticalDirection.,
            //     children: <Widget>[
            //       Container(
            //         child: GestureDetector(
            //             onTap: () {
            //               Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         fullscreenDialog: true,
            //         builder: (BuildContext context) => CategoryScreen(e['category']['id'].toString() , e['category']['name']),
            //       ),
            // );
            //             }, child: Text(e['category']['name'])),
            //         width: double.infinity,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //       ),
            //     ],
            //   ),
            Container(
              color: Colors.white,
              height: 330,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: e['products'].length,
                itemBuilder: (context, index) {
                  Product product = Product.fromJson(e['products'][index]);

                  return productPartial(product, _deviceSize, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) async {
        isLoading = true;
        await model.fetchProducts();
        await model.fetchCategories(widget.id);
        if (!model.hasChildren) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) =>
                    ShopScreen(widget.slug, "", "", "")),
          );
        }
        await model.fetchCart();
        await model.fetchAges();
        await model.fetchAuthors();
        await model.fetchLnaguages();
        await model.getUser();
        print(model.categories);
        isLoading = false;

        // model.fetchProducts();
      },
      builder: (context, child, model) => Loader(
        show: false,
        child: Scaffold(
            appBar: buildAppBar(context, widget.name ,model),
            drawer: AppDrawer(
                categories: model.categories,
                user: model.user,
                languages: model.languages,
                authors: model.authors,
                ages: model.ages),
            body: Container(
              color: Colors.white,
              child: isLoading
                  ? Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text('Loading'),
                            )),
                      ],
                    )
                  : CustomScrollView(slivers: _buildCarousels(model, context)),
            ),
            bottomNavigationBar: AppBottomNavigationBar(
              index: 1,
            )),
      ),
    );
  }
}

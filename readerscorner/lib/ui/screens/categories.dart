import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/category.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);
  Widget _buildCat(cat , context) {
    String image = cat.image != null ? cat.image : "https://hackernoon.com/hn-images/1*XizMTzpgcBgL9eBkTfKc_Q.jpeg";
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => CategoryScreen(cat.id.toString(), cat.slug, cat.name),
            ),
          );
      },
          child: Container(
         height: 150.0,
         width: double.infinity,
          margin: EdgeInsets.only(bottom:10),
            child: GFCard(
        boxFit: BoxFit.cover,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(9),
        imageOverlay: NetworkImage(image),
        titlePosition: GFPosition.start,
        title: GFListTile(
          
           title:Center(child: Text(cat.name , style:TextStyle(color:Colors.white , fontWeight:FontWeight.bold , fontSize:22 ), textAlign:TextAlign.center ,)),
           
         ),
         
   ),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) async {
        await model.fetchCategories("");
        print(model.categories);
        // model.fetchProducts();
      },
      builder: (context, child, model) => Scaffold(
          body: ListView.builder(
              itemCount: model.categories.length,
              itemBuilder: (context, i) {
                return _buildCat(model.categories[i] , context);
              }),
          bottomNavigationBar: AppBottomNavigationBar(
            index: 1,
          )),
    );
  }
}

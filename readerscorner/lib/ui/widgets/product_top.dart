import 'package:flutter/material.dart';
import 'package:readerscorner/models/Product.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
Widget _appbar(context){
  return Align(
  heightFactor: 0.35,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text('')),
      Expanded(
        child: Container(),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: IconButton(
          onPressed: ()=>{
              Navigator.pushNamed(context, '/cart')
          },
                  icon: Icon(
            Icons.shopping_cart,
            color: Colors.black87,
          ),
        ),
      )
    ],
  ),
);

} 
                                                          

Widget content(Product product , MainModel model , BuildContext context
) {
  bool isFav = false;
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
                child: Image(
                  width: 150.0,
                  height: 180.0,
                  image: NetworkImage(product.image),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              Flexible(
              child : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  product.author_name != null ? GestureDetector( onTap: (){} ,child: RichText(text: TextSpan(text: 'Author : ${product.author_name.trim()}'),)) : Text(''),
                  RichText(text: TextSpan(text: 'Isbn :${product.isbn}'),)
                  
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
                      final Map<String, dynamic> _data = {"product" :product.id , "qunatinty" : "1"};
                          if(product.order_limit > 0 ){
                            model.addToCart(_data , context);
                            model.showFlushBar(context, "Item added successfully");

                          }else{
                            model.showFlushBar(context, "Sorry item is not avilable");

                          }
                    },
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    child: Text('Add To Cart'),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              Text('EGP${product.price}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              GestureDetector(
                onTap: (){
                      final Map<String, dynamic> _data = {"product" :product.id , "qunatinty" : "1"};
                  model.addToWishlist(_data , context);
                  isFav = true;
                },
                              child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: isFav ? Colors.red : Colors.transparent,
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

class MHeader extends StatelessWidget {
  final Product curProduct;
  MHeader(this.curProduct);
  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
          builder: (context, child, model) => Container(
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
              child: content(curProduct , model , context),
            ),
            _appbar(context)
          ],
        ),
      ),
    );
  }
}

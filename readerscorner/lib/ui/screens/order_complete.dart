import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/shop.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
         Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Icon(
            IconData(0xe8f6, fontFamily: 'MaterialIcons'),
            color: Theme.of(context).primaryColor,
            size: 150.0,
          ),
          Text('THANK YOU!' , style: TextStyle(fontSize:20,color:Theme.of(context).primaryColor),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : 30.0),
            child: Text('For ordering in our shop , you will recieve e-mail confirmation shortly , Let\'s looks our recomended items' , style: TextStyle(),textAlign: TextAlign.center,),
          ),
          Padding(padding: EdgeInsets.only(top:30)),
          Container(padding: EdgeInsets.symmetric(horizontal:50) , width : double.infinity ,child: RaisedButton(onPressed: (){
             Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) =>ShopScreen("","","","")),
        );
          },child:Text('CONTINUE SHOPPING' , style:TextStyle(color:Colors.white)),color: Theme.of(context).primaryColor, padding: EdgeInsets.symmetric(vertical:10 ),))
        ])),
      
    );
  }
}

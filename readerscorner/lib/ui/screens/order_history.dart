import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/order_details.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';
import 'package:readerscorner/ui/widgets/loader.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget _buildOrderCard(order , context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => OrderDetailsScreen(order)
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:20 , vertical :10),
          decoration:BoxDecoration(border: Border.all(color: Colors.black12), color: Color(0xfff7f7f7),),
          child: Row(
            children:<Widget>[
              RichText(text: TextSpan(text: 'Order ID :#${order.id}' , style: TextStyle(color:Color(0xff202020))),)
            ]
          ),
        )
      ),
    );
  }

  List<Widget> _buildWidgets(model , context) {
    List<Widget> widgets = [];
    for (var i = 0; i < model.orders.length; i++) {
      Widget order = _buildOrderCard(model.orders[i] , context);
      widgets.add(order);
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) async {
          await model.fetchOrders();
          await model.fetchCart();
          // model.fetchProducts();
        },
        builder: (context, child, model) => Loader(
            show: false,
            child: Scaffold(
              appBar: buildAppBar(context, 'ORDERS' , model),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(children: _buildWidgets(model , context)),
                ))));
              //  FloatingActionButton(onPressed: () async{
              //    await model.fetchOrders();
              //    print(model.orders);

              //  })
  }

  
}

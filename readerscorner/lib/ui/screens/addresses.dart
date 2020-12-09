import 'package:flutter/material.dart';
import 'package:readerscorner/models/Address.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/screens/editadd_address.dart';
import 'package:readerscorner/ui/widgets/address.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';
import 'package:readerscorner/ui/widgets/btn.dart';
import 'package:readerscorner/ui/widgets/loader.dart';

import 'package:readerscorner/ui/widgets/bottomNavbar.dart';
import 'package:getflutter/getflutter.dart';

class AddressesScreen extends StatelessWidget {
 
  @override
  

  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) async {
          await model.fetchAddresses();
          await model.fetchCities();
          print(model.addresses);
          // model.fetchProducts();
        },
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
          elevation: 10.0,
          title: Text("ADDRESSES"),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) => EditAddAddress(Address()),
                          ),
                        );
                }),
          ],
        ),
            body:Container(
              padding: EdgeInsets.symmetric(vertical:20),
              child :
                // _buildAddAddress(model, context),
                ListView.builder(
                  itemCount: model.addresses.length,
                  itemBuilder:(context , index){
                 return buildAddress(context , model ,index);

                  } 
                
                ),
              
            ),
            
            
            
            bottomNavigationBar: AppBottomNavigationBar(
              index: 3,
            )));
  }
}

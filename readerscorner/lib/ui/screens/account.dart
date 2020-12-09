import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/addresses.dart';
import 'package:readerscorner/ui/screens/login.dart';
import 'package:readerscorner/ui/screens/order_history.dart';
import 'package:readerscorner/ui/screens/wishlist.dart';
import 'package:readerscorner/ui/widgets/logo.dart';
import 'package:readerscorner/ui/widgets/btn.dart';
import 'package:readerscorner/ui/widgets/text.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "email": "",
    "password": "",
  };
  _buildDialog(BuildContext context , points)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pointss = prefs.getString('points');
    return showDialog(context: context , builder :(context){
      return AlertDialog(
        title:Icon(
                      IconData(0xe8f6, fontFamily: 'MaterialIcons'),
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
        content: pointss == null ? Center(child: Container( width: 50 , height: 50 , child: CircularProgressIndicator())) :Text('You have ${pointss} Points'),
        actions: <Widget>[
          MaterialButton(color:Theme.of(context).primaryColor ,child:Text('ok'),elevation: 5,onPressed: (){
            Navigator.of(context).pop();
          },)
        ],
      );

    }

    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) async {
          await model.getUser();
           await model.fetchPoints();
          print(model.user);
          // model.fetchProducts();
        },
        builder: (context, child, model) => Loader(
              show: false,
              child: Scaffold(
                  body: ListView(
                    children: <Widget>[
                      Container(
                        color: Color(0xffd9d9d9),
                        height: 200,
                        width: double.infinity,

                        child: Column(children: <Widget>[
                          model.user == null
                              ? Text('Loading')
                              : Text(
                                  model.user.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                          model.user == null
                              ? Text('')
                              : Text(
                                  model.user.email,
                                ),
                        ], mainAxisAlignment: MainAxisAlignment.center),
                        // accountName: Text('name'),
                        // accountEmail: Text('email@email.com'),
                      ),
                      ListTile(
                        leading: Icon(
                          IconData(0xe935, fontFamily: 'MaterialIcons'),
                          color: Color(0xff94939d),
                          size: 20.0,
                        ),
                        title: new Text("ORDER HISTORY",
                            style: TextStyle(color: Color(0xff94939d))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  OrderHistoryScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.favorite_border,
                          color: Color(0xff94939d),
                          size: 20.0,
                        ),
                        title: new Text("WISHLIST",
                            style: TextStyle(color: Color(0xff94939d))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  WishListScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          IconData(0xe7f1, fontFamily: 'MaterialIcons'),
                          color: Color(0xff94939d),
                          size: 20.0,
                        ),
                        title: new Text("SHIPPING ADDRESSES",
                            style: TextStyle(color: Color(0xff94939d))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  AddressesScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          IconData(0xe879, fontFamily: 'MaterialIcons'),
                          color: Color(0xff94939d),
                          size: 20.0,
                        ),
                        title: new Text("MY POINTS",
                            style: TextStyle(color: Color(0xff94939d))),
                        onTap: () {
                      // int points = 120;
                       model.fetchPoints();
                     
                      _buildDialog(context , model.points);
                      // _buildDialog(context , points);
                    },
                      ),
                      Divider(),

                      ListTile(
                        leading: Icon(
                          IconData(0xe8f6, fontFamily: 'MaterialIcons'),
                          color: Color(0xff94939d),
                          size: 20.0,
                        ),
                        title: Text("LOGOUT",
                            style: TextStyle(color: Color(0xff94939d))),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          await prefs.remove('token');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        },
                      ),

                      // Visibility(
                      //   visible: loading ?? true,
                      //   child: Center(
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       color: Colors.white.withOpacity(0.9),
                      //       child: CircularProgressIndicator(
                      //         valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  bottomNavigationBar: AppBottomNavigationBar(
                    index: 3,
                  )),
            ));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      initialValue: 'test@test.comseconds',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Email is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      initialValue: 'testttt',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 6+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }
}

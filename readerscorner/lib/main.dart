import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/account.dart';
import 'package:readerscorner/ui/screens/cart.dart';
import 'package:readerscorner/ui/screens/categories.dart';
import 'package:readerscorner/ui/screens/intro.dart';
import 'package:readerscorner/ui/screens/intro_auth.dart';
import 'package:readerscorner/ui/screens/login.dart';
import 'package:readerscorner/ui/screens/register.dart';
import 'package:readerscorner/ui/screens/home.dart';

import 'package:readerscorner/ui/screens/addresses.dart';
import 'package:readerscorner/ui/screens/order_history.dart';
import 'package:readerscorner/ui/screens/wishlist.dart';

import 'package:readerscorner/utils/service_locator.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  @override
  void initState() { 
    super.initState();
    _model.autoAuthenticate();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
          model: _model,
          child: MaterialApp(
        title: 'readerscorner',
        routes: {
          '/': (BuildContext context) => ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  if(model.isUserLoading){
                    return Loader();
                  }
                  return model.user == null ? IntroScreen() : HomeScreen();
                },
              ),
          '/cart' : (BuildContext context) => CartPage(),
          
          '/introAuth': (BuildContext context) => IntroAuthScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/register': (BuildContext context) => RegisterScreen(),
          '/home': (BuildContext context) => HomeScreen(),
          '/account': (BuildContext context) => AccountScreen(),
          '/cateogirs': (BuildContext context) => CategoriesScreen(),
          '/addresses': (BuildContext context) => AddressesScreen(),
          '/orders': (BuildContext context) => OrderHistoryScreen(),
          '/wishlist': (BuildContext context) => WishListScreen(),
          
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen());
        },
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          primaryColor: Color(0xff27b09e),
          accentColor: Color(0xff68097c),
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}

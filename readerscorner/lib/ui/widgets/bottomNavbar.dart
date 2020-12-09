import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/account.dart';
import 'package:readerscorner/ui/screens/categories.dart';
import 'package:readerscorner/ui/screens/home.dart';
import 'package:readerscorner/ui/screens/shop.dart';

class AppBottomNavigationBar extends StatefulWidget {
 AppBottomNavigationBar({this.index});
  final int index;

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  
  final List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    ShopScreen("" , "" , "" , ""),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation:6.0,
      onTap: (int index) => setState(() {
       
        if(index == 0 || index == 2){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => pages[index]),
        );
        }else{
          Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => pages[index]),
        );
        }
        
      }),
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), title: Text("Categories")),
        BottomNavigationBarItem(
            icon: Icon(Icons.book), title: Text("Shop")),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text("My Account")),
      ],
    );
  }
}

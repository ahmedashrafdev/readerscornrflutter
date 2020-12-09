import 'package:flutter/material.dart';
import 'package:readerscorner/models/Filter.dart';
import 'package:readerscorner/models/User.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:getflutter/getflutter.dart';
import 'package:readerscorner/ui/screens/addresses.dart';
import 'package:readerscorner/ui/screens/home.dart';
import 'package:readerscorner/ui/screens/login.dart';
import 'package:readerscorner/ui/screens/order_history.dart';
import 'package:readerscorner/ui/screens/shop.dart';
import 'package:readerscorner/ui/screens/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<String> items) {
  return List.generate(items.length, (int index) {
    return generateItem(items[index]);
  });
}

Item generateItem(item) {
  return Item(
    headerValue: item,
    expandedValue: 'mine',
  );
}

class AppDrawer extends StatefulWidget {
  // AppDrawer({Key key}) : ;
  final List<Filter> categories;
  final User user;
  final List<Filter> authors;
  final List<Filter> languages;
  final List<Filter> ages;
  AppDrawer({
    this.categories,
    this.user,
    this.authors,
    this.languages,
    this.ages,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String category = "";
  String language = "";
  String author = "";
  String age = "";
  var timeDilation;

  _buildDialog(BuildContext context , model) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pointss = prefs.getString('points');
    print(pointss);
    return showDialog(context: context , builder :(context){
      return AlertDialog(
        title:Icon(
                      IconData(0xe8f6, fontFamily: 'MaterialIcons'),
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
        content:  pointss == null ? Center(child: Container( width: 50 , height: 50 , child: CircularProgressIndicator())) :Text('You have ${pointss} Points'),
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
      builder: (context, child, model) => Drawer(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView(
                children: <Widget>[
                  
                  Container(
                    color: Color(0xffd9d9d9),
                    height: 200,
                    width: double.infinity,

                    child: Container(
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
                    // accountName: Text('name'),
                    // accountEmail: Text('email@email.com'),
                  ),
                  GFAccordion(
                      title: 'Categories',
                      contentChild: Column(
                          children: _filterCategories(widget.categories))),
                  GFAccordion(
                      title: 'Authors',
                      contentChild:
                          Column(children: _filterAuthors(widget.authors))),
                  GFAccordion(
                      title: 'Languages',
                      contentChild:
                          Column(children: _filterLnaguages(widget.languages))),
                  GFAccordion(
                      title: 'Ages',
                      contentChild: Column(children: _filterAges(widget.ages))),
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
                          builder: (BuildContext context) => WishListScreen(),
                        ),
                      );
                    },
                  ),
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
                          builder: (BuildContext context) => AddressesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      IconData(0xe8f6, fontFamily: 'MaterialIcons'),
                      color: Color(0xff94939d),
                      size: 20.0,
                    ),
                    title: new Text("MY POINTS",
                        style: TextStyle(color: Color(0xff94939d))),
                    onTap: () async {
                      //  model.fetchPoints();
                     
                       _buildDialog(context , model);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      IconData(0xe879, fontFamily: 'MaterialIcons'),
                      color: Color(0xff94939d),
                      size: 20.0,
                    ),
                    title: Text("LOGOUT",
                        style: TextStyle(color: Color(0xff94939d))),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                     
                      await prefs.remove('token');
                     
                      
                      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => LoginScreen()),
  (Route<dynamic> route) => false,
);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                            ShopScreen(category, age, language, author)),
                  );
                },
                color: Theme.of(context).primaryColor,
                child: Text('Apply Filters',
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _filterCategories(List<Filter> filter) {
    List<Widget> widgets = [];
    filter.asMap().forEach((index, value) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: 10),
        color: Color(0xfff7f7f7),
        child: CheckboxListTile(
          title: Text(filter[index].name),
          value: filter[index].isSelected,
          onChanged: (bool value) {
            setState(() {
              filter.forEach((item) {
                item.isSelected = false;
              });
              filter[index].isSelected = value == false ? false : true;
              category = filter[index].slug;
              // author = filter[index].slug;
              // print('val');
              // print(val);
              // print(filter[index]);
              // value = value == true ? false : true;
            });
          },
        ),
      ));
    });
    return widgets;
  }

  List<Widget> _filterAuthors(List<Filter> filter) {
    List<Widget> widgets = [];
    filter.asMap().forEach((index, value) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: 10),
        color: Color(0xfff7f7f7),
        child: CheckboxListTile(
          title: Text(filter[index].name),
          value: filter[index].isSelected,
          onChanged: (bool value) {
            setState(() {
              filter.forEach((item) {
                item.isSelected = false;
              });
              filter[index].isSelected = value == false ? false : true;
              author = filter[index].slug;
              // author = filter[index].slug;
              // print('val');
              // print(val);
              // print(filter[index]);
              // value = value == true ? false : true;
            });
          },
        ),
      ));
    });
    return widgets;
  }

  List<Widget> _filterLnaguages(List<Filter> filter) {
    List<Widget> widgets = [];
    filter.asMap().forEach((index, value) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: 10),
        color: Color(0xfff7f7f7),
        child: CheckboxListTile(
          title: Text(filter[index].name),
          value: filter[index].isSelected,
          onChanged: (bool value) {
            setState(() {
              filter.forEach((item) {
                item.isSelected = false;
              });
              filter[index].isSelected = value == false ? false : true;
              language = filter[index].slug;
              // author = filter[index].slug;
              // print('val');
              // print(val);
              // print(filter[index]);
              // value = value == true ? false : true;
            });
          },
        ),
      ));
    });
    return widgets;
  }

  List<Widget> _filterAges(List<Filter> filter) {
    List<Widget> widgets = [];
    filter.asMap().forEach((index, value) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: 10),
        color: Color(0xfff7f7f7),
        child: CheckboxListTile(
          title: Text(filter[index].name),
          value: filter[index].isSelected,
          onChanged: (bool value) {
            setState(() {
              filter.forEach((item) {
                item.isSelected = false;
              });
              filter[index].isSelected = value == false ? false : true;
              age = filter[index].slug;
              // author = filter[index].slug;
              // print('val');
              // print(val);
              // print(filter[index]);
              // value = value == true ? false : true;
            });
          },
        ),
      ));
    });
    return widgets;
  }
}

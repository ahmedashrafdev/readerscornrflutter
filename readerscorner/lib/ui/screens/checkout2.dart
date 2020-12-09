// import 'package:flutter/material.dart';
// import 'package:readerscorner/scoped-models/main_model.dart';
// import 'package:readerscorner/ui/base_view.dart';
// import 'package:readerscorner/ui/widgets/confirm.dart';
// import 'package:readerscorner/ui/widgets/shipping.dart';
// import 'package:readerscorner/models/Address.dart';
// import 'package:readerscorner/ui/screens/editadd_address.dart';

// class ChecoutScreen extends StatefulWidget {
//   @override
//   _ChecoutScreenState createState() => _ChecoutScreenState();
// }

// class _ChecoutScreenState extends State<ChecoutScreen>
//     with SingleTickerProviderStateMixin {
//   final List<Tab> myTabs = <Tab>[
//     new Tab(text: 'Shipping'),
//     new Tab(text: 'Confirm'),
//   ];
//   TabController _tabController;
//   bool _show = true;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(vsync: this, length: myTabs.length);
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseView<MainModel>(
//         onModelReady: (model) {
//           model.fetchCart();
//           model.getUser();
//           model.fetchAddresses();
//           print(model.cart);
//           // model.fetchProducts();
//         },
//         builder: (context, child, model) => DefaultTabController(
//               length: 2,
//               child: Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: Colors.white,
//                   bottom: TabBar(
//                     unselectedLabelColor: Colors.black,
//                     controller: _tabController,
//                     labelColor: Colors.orange,
//                     tabs: myTabs,
//                   ),
//                   title: Text('Checkout'),
//                   centerTitle: true,
//                 ),
//                 body: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     ShippingTab(),
//                     ConfirmTab(),
//                   ],
//                 ),
//                 // bottomSheet: Column(
//                 //   children: <Widget>[
//                 //     Padding(
//                 //         padding:
//                 //             EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 //         child: RaisedButton(
//                 //           color: Theme.of(context).primaryColor,
//                 //           child: Text('Continue'),
//                 //           onPressed: () {},
//                 //         )),
//                 //     Padding(
//                 //         padding:
//                 //             EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 //         child: RaisedButton(
//                 //           color: Theme.of(context).primaryColor,
//                 //           child: Text('Add address'),
//                 //           onPressed: () {
//                 //             Navigator.push(
//                 //               context,
//                 //               MaterialPageRoute(
//                 //                 fullscreenDialog: true,
//                 //                 builder: (BuildContext context) =>
//                 //                     EditAddAddress(Address()),
//                 //               ),
//                 //             );
//                 //           },
//                 //         )),
//                 //   ],
//                 // ),
//                 bottomSheet: Container(
//                     height: 120,
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                     child: _show
//                         ? Column(
//                             children: <Widget>[
//                               Container(
//                                 width: double.infinity,
//                                 child: RaisedButton(
//                                   color: Theme.of(context).primaryColor,
//                                   child: Text('Add Address'),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         fullscreenDialog: true,
//                                         builder: (BuildContext context) =>
//                                             EditAddAddress(Address()),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 child: RaisedButton(
//                                   color: Theme.of(context).primaryColor,
//                                   child: Text('Continue'),
//                                   onPressed: () {
//                                     _tabController.animateTo(1);
//                                     setState(() {
//                                     _show = false;
                                      
//                                     });
//                                   } 
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Column(
//                             children: <Widget>[
//                               Container(
//                                 color: Colors.orange,
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.symmetric(vertical: 20),
//                                 child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 25),
//                                         child: Text(
//                                           "TOTAL",
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 25),
//                                           child: Text(
//                                             '${model.total}',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           )),
//                                     ]),
//                               ),
//                               Container(
//                                 color: Colors.black,
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.symmetric(vertical: 20),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     model.checkout({}, context);
//                                   },
//                                   child: Center(
//                                       child: Text(
//                                     "Confirm",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   )),
//                                 ),
//                               )
//                             ],
//                           )),
//                 // floatingActionButton: new FloatingActionButton(
//                 //   onPressed: () => _tabController
//                 //       .animateTo((_tabController.index + 1) % 2), // Switch tabs
//                 //   child: new Icon(Icons.swap_horiz),
//                 // ),
//               ),
//             ));
//   }
// }

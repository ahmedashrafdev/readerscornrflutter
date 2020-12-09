import 'package:readerscorner/models/Address.dart';
import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/appBar.dart';
import 'package:readerscorner/ui/widgets/register_fields.dart';
import 'package:readerscorner/ui/widgets/bottomNavbar.dart';

class EditAddAddress extends StatefulWidget {
  final Address address;

  EditAddAddress(this.address);

  @override
  _EditAddAddressState createState() => _EditAddAddressState();
}

class _EditAddAddressState extends State<EditAddAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _editAddressformData = {};

  String initialValue = "test";

  List<String> edited = [];

  Widget _buildAddAddress(model, context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: Column(children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Column(
                children: <Widget>[
                  buildTitleTextField(widget.address.title, (value) {
                    _editAddressformData['title'] = value;
                  }),
                  buildPostalTextField(widget.address.postal, (value) {
                    _editAddressformData['postal'] = value;
                  }),
                  buildCityTextField2(widget.address.city_id, model.cities,
                      (value) {
                    _editAddressformData['city_id'] = value;
                  }),
                  buildPhoneTextField(widget.address.phone, (value) {
                    _editAddressformData['phone'] = value;
                  }),
                  buildBuildingTextField(widget.address.building, (value) {
                    _editAddressformData['building'] = value;
                  }),
                  buildApartmentTextField(widget.address.apartment, (value) {
                    _editAddressformData['apartment'] = value;
                  }),
                  buildStreetTextField(widget.address.street, (value) {
                    _editAddressformData['street'] = value;
                  }),
                  buildFloorTextField(widget.address.floor, (value) {
                    _editAddressformData['floor'] = value;
                  }),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Save'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        print(_editAddressformData);
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        widget.address.id != null ? 
                        model.editAddress(widget.address.id,_editAddressformData, context) :
                        model.addAddress(_editAddressformData, context) 
                        
                        ;
                        // Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) async {
          await model.fetchCities();
await model.fetchCart();
          // model.fetchProducts();
        },
        builder: (context, child, model) => Scaffold(
            appBar: buildAppBar(context, ' ADDRESSES' , model),
            body: ListView(children: <Widget>[_buildAddAddress(model, context)]
                // _buildAddAddress(model, context),

                ),
            bottomNavigationBar: AppBottomNavigationBar(
              index: 3,
            )));
  }
}

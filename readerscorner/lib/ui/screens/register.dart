import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:readerscorner/ui/widgets/register_fields.dart';
import 'package:flushbar/flushbar.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    "name": "",
    "email": "",
    "password": "",
    "city_id": "",
    "phone": "",
    "title": "",
    "building": "",
    "postal": "",
    "apartment": "",
    "street": "",
    "floor": "",
  };
   Widget buildCityTextField(cities) {

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical :8.0),
      child: DropDownFormField(
        titleText: 'City',
        hintText: 'Please choose one',
        
        validator: (value) {
          // if (value.trim().length <= 0) {
          if (value == null) {
            return 'City is required.';
          }
        },
        // value: selected,
         onChanged: (value) {
          setState(() {
          _formData['city_id'] = value;    
          });
        },
        // value:{
        //       "display": "cairo",
        //       "value": "1",
        //     },

        
        // dataSource: [{"display":"as" , "value":"calue"}],
        dataSource: cities.map(
          (city) {
            return {
              "display": city.name,
              "value": city.id,
            };
          },
        ).toList(),
      
        textField: 'display',
        valueField: 'value',
         value: _formData['city_id'],
      ),
    );
  }
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
      onModelReady: (model) => model.fetchCities(),
      builder: (context, child, model) => Loader(
        show: false,
        child: Scaffold(
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 150.0,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage("images/sucover.jpg"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          buildNameTextField("" ,(value){
                            _formData['name'] = value;
                          }),
                          buildEmailTextField("" ,(String value){
                            _formData['email'] = value;
                          }),
                          buildPasswordTextField("" ,(value){
                            _formData['password'] = value;
                          }),
                         
                          buildTitleTextField("" ,(value){
                            _formData['title'] = value;
                          }),
                          
                          buildPostalTextField("" ,(value){
                            _formData['postal'] = value;
                          }),
                          buildCityTextField(model.cities),
                          buildPhoneTextField("" ,(value){
                            _formData['phone'] = value;
                          }),
                          buildBuildingTextField("" ,(value){
                            _formData['building'] = value;
                          }),
                          buildApartmentTextField("" ,(value){
                            _formData['apartment'] = value;
                          }),
                          buildStreetTextField("" ,(value){
                            _formData['street'] = value;
                          }),
                          buildFloorTextField("" ,(value){
                            _formData['floor'] = value;
                          }),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text('Save'),
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                model.register(_formData, context);
                              },
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlertDialog(context) {
    return AlertDialog(
      title: Text('Rewind and remember'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('You registered successfully'),
            Text('Pleas login'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
            // Navigator.push(context, route);
          },
        ),
      ],
    );
  }

  void showSimpleFlushBar(BuildContext context) {
    Flushbar(
      message: "registred successfult",
      mainButton: FlatButton(
        child: Text('login'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

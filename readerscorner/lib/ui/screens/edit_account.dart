import 'package:flutter/material.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/loader.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flushbar/flushbar.dart';

class EditAccountScreen extends StatelessWidget {
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildNameTextField(),
                        _buildEmailTextField(),
                        _buildPasswordTextField(),
                        _buildTitleTextField(),
                        _buildPostalTextField(),
                        _buildCityTextField(model),
                        _buildPhoneTextField(),
                        _buildBuildingTextField(),
                        _buildApartmentTextField(),
                        _buildStreetTextField(),
                        _buildFloorTextField(),
                        RaisedButton(
                          child: Text('Save'),
                          textColor: Colors.white,
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            model.register(_formData, context);
                          },
                        )
                      ],
                    )),
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

  Widget _buildPostalTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'postal'),
      initialValue: '15243',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Title is required.';
        }
      },
      onSaved: (String value) {
        _formData['postal'] = value;
      },
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: 'testtttt',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
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

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address Title'),
      initialValue: 'testttt',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 6+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildCityTextField(model) {
    return DropDownFormField(
      titleText: 'City',
      hintText: 'Please choose one',
      onSaved: (value) {
        _formData['city_id'] = value;
      },
      dataSource: model.cities.map(
        (city) {
          return {
            "display": city.name,
            "value": city.id,
          };
        },
      ).toList(),
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone'),
      initialValue: 'test',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Phone is required.';
        }
      },
      onSaved: (String value) {
        _formData['phone'] = value;
      },
    );
  }

  Widget _buildBuildingTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Building'),
      initialValue: 'test',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Building is required.';
        }
      },
      onSaved: (String value) {
        _formData['building'] = value;
      },
    );
  }

  Widget _buildApartmentTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apartment'),
      initialValue: 'test',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Apartment is required.';
        }
      },
      onSaved: (String value) {
        _formData['apartment'] = value;
      },
    );
  }

  Widget _buildStreetTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Street'),
      initialValue: 'test',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Street is required.';
        }
      },
      onSaved: (String value) {
        _formData['street'] = value;
      },
    );
  }

  Widget _buildFloorTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Floor'),
      initialValue: 'test',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Floor is required.';
        }
      },
      onSaved: (String value) {
        _formData['floor'] = value;
      },
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

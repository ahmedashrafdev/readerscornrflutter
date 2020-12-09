import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

Widget buildPostalTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'postal'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Title is required.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildNameTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildEmailTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Email is required and should be 5+ characters long.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildPasswordTextField(value , onSaved) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 6+ characters long.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildTitleTextField(value ,onChanged ) {
   var onSavedFunc = value == "" ?  onChanged : (value) {} ;
   var onChangedFunc = value == "" ?   (value) {}: onChanged ;
   
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address Title'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty ) {
          return 'Title is required ';
        }
      },
      
      onSaved: onSavedFunc,
      onChanged: onChangedFunc,);
  }

  Widget buildCityTextField2(selected ,cities , onSaved) {

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
        onSaved:onSaved,
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
         value: selected,
      ),
    );
  }

  Widget buildPhoneTextField(value , onSaved) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'Phone'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Phone is required.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildBuildingTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Building'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Building is required.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildApartmentTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apartment'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Apartment is required.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildStreetTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Street'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Street is required.';
        }
      },
      onSaved:onSaved
    );
  }

  Widget buildFloorTextField(value , onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Floor'),
      initialValue:value,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'Floor is required.';
        }
      },
      onSaved:onSaved
    );
  }
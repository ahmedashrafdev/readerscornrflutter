import 'package:flutter/material.dart';
Widget appTextField(
    {String textHint = "",
    bool isPassword,
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    TextInputType textType = TextInputType.text,
    TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
    child: Material(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword == null ? false : isPassword,
          decoration: InputDecoration(
            hintText: textHint,
          ),
          validator :  (value) {
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value))
                return 'Please make sure your email address is valid';
              else
                return null;
          },
          
        ),
      ),
    ),
  );
}

import 'package:readerscorner/models/City.dart';

import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;

class AuthModel extends Model {
 List<City> _cities = [];
 List<City> get cities => List.from(_cities);
  String responseMsg;

  
  


  
  
}
// import 'package:readerscorner/models/User.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GetUserService {
//  void getUser(token) async{
//     final response = await http.get(
//         'http://192.168.1.104:8000/api/user',

//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
      
//      if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         user = User(
//           id: responseData['id'] ,
//           name: responseData['name'] ,
//           email: responseData['email'],
//           password: responseData['password'],
//           city_id: responseData['city_id'],
//           phone: responseData['phone'],
//           token: responseData['token'],
//         );
//         // fetchAddresses();
//         notifyListeners();
//       }
//   }
// }
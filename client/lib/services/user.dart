import 'dart:async';
import 'dart:convert';
import 'package:client/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

Future<Map<String, dynamic>> createUser(User user) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> json = {
    "first_name": user.firstName,
    "last_name": user.lastName,
    "password": user.password,
    "userName": user.userName,
    "role": user.role.toString().split('.').last.toLowerCase(),
  };
  http.Response response;
  try {
    response = await http.post('${constants.API}/newUser',
      headers: headers, body: jsonEncode(json));
  } catch(_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

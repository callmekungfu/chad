import 'dart:async';
import 'dart:convert';
import 'package:client/models/credential.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

Future<Map<String, dynamic>> authenticate(Credential credential) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> json = {
    "password": credential.password,
    "userName": credential.userName,
  };
  http.Response response;
  try {
    response = await http.post('${constants.API}/login',
      headers: headers, body: jsonEncode(json));
  } catch(_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  if (response.statusCode == 204) {
    Map<String, dynamic> output = {};
    output['statusCode'] = response.statusCode;
    output['msg'] = 'Invalid Credentials';
    return output;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}
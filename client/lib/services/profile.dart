import 'dart:async';
import 'dart:convert';
import 'package:client/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

Future<Map<String, dynamic>> createProfile(Profile profile) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> json = {
    "email": profile.email,
    "company": profile.companyName,
    "phoneNumber": profile.phoneNumber,
    "address": profile.address,
    "description": profile.description,
    "isLiscensed": profile.liscensed,
  };
  http.Response response;
  try {
    response = await http.put('${constants.API}/providers',
        headers: headers, body: jsonEncode(json));
  } catch (_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

Future<Profile> getProfile(String email) async {
  http.Response response;
  try {
    response = await http.get("${constants.API}/providers/$email");
    print(response);
  } catch (_) {
    print(_);
    return null; //TODO return an error response
  }

  var jsonData = json.decode(response.body);

  Profile profile;
  var data = jsonData['data'];

  profile.email = data['email'];
  profile.companyName = data['company'] != null ? data['company'] : '';
  profile.phoneNumber = data['phoneNumber'] != null ? data['phoneNumber'] : '';
  profile.address = data['address'] != null ? data['address'] : '';
  profile.description = data['description'] != null ? data['description'] : '';
  profile.liscensed = data['isLiscensed'] != null ? data['isLiscensed'] : false;

  return profile;
}

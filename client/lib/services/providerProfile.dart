import 'dart:async';
import 'dart:convert';
import 'package:client/models/providerProfile.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

Future<Map<String, dynamic>> createProviderProfile(ProviderProfile _profile) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> json = {
    "email": _profile.email,
    "company": _profile.companyName,
    "phoneNumber": _profile.phoneNumber,
    "address": _profile.address,
    "description": _profile.description,
    "isLiscensed": _profile.liscensed,
  };
  http.Response response;
  try {
    response = await http.post('${constants.DEV_API}/providers',
        headers: headers, body: jsonEncode(json));
  } catch (_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

Future<Map<String, dynamic>> updateProviderProfile(ProviderProfile _profile) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> json = {
    "email": _profile.email,
    "company": _profile.companyName,
    "phoneNumber": _profile.phoneNumber,
    "address": _profile.address,
    "description": _profile.description,
    "isLiscensed": _profile.liscensed,
  };
  http.Response response;
  try {
    response = await http.put('${constants.DEV_API}/providers/${_profile.id}',
        headers: headers, body: jsonEncode(json));
  } catch (_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

Future<ProviderProfile> getProviderProfile(String id) async {
  http.Response response;
  try {
    response = await http.get("${constants.DEV_API}/providers/$id");
    print(response);
  } catch (_) {
    print(_);
    return null; //TODO return an error response
  }

  var jsonData = json.decode(response.body);

  ProviderProfile _profile = new ProviderProfile();
  var data = jsonData['provider']['data'];

  _profile.companyName = data['company'] != null ? data['company'] : '';
  _profile.phoneNumber = data['phoneNumber'] != null ? data['phoneNumber'] : '';
  _profile.address = data['address'] != null ? data['address'] : '';
  _profile.description = data['description'] != null ? data['description'] : '';
  _profile.liscensed = data['isLiscensed'] != null ? data['isLiscensed'] : false;
  return _profile;
}

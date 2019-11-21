import 'dart:async';
import 'dart:convert';
import 'package:client/models/providerProfile.dart';
import 'package:client/models/service.dart';
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
    response = await http.post('${constants.API}/providers',
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
    "company": _profile.companyName,
    "phoneNumber": _profile.phoneNumber,
    "address": _profile.address,
    "description": _profile.description,
    "isLiscensed": _profile.liscensed,
  };
  json.addAll(_profile.availabilities.toMap());
  http.Response response;
  try {
    response = await http.put('${constants.API}/providers/${_profile.id}',
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
    response = await http.get("${constants.API}/providers/$id");
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
  _profile.availabilities.monday = data['monday'];
  _profile.availabilities.tuesday = data['tuesday'];
  _profile.availabilities.wednesday = data['wednesday'];
  _profile.availabilities.thursday = data['thursday'];
  _profile.availabilities.friday = data['friday'];
  _profile.availabilities.saturday = data['saturday'];
  _profile.availabilities.sunday = data['sunday'];

  List<Service> services = [];
  
  for (var s in jsonData['provider']['services']) {
      var data = s['data'];
      if(data['name']!=null){
        var service = Service(
        id: s['id'], 
        name: data['name'],
        role: (data['role']!=null)?data['role']:'',
        price: (data['price']!=null)?data['price'].toDouble():0.0,
      );
      services.add(service);
    }
  }
  _profile.services = services;

  return _profile;
}

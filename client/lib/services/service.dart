
import 'dart:convert';

import 'package:client/models/service.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

Future<Map<String, dynamic>> createService(Service service) async {
  Map<String, String> headers = {
    'Content-type': 'application/json'
  };
  Map<String, dynamic> body = {
    'name': service.name,
    'role': service.role,
    'price': service.price
  };
  http.Response response;

  try {
    response = await http.post('${constants.DEV_API}/services',
      headers: headers, body: jsonEncode(body));
  } catch(_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

Future<Map<String, dynamic>> editService(Service service) async {
  Map<String, String> headers = {
    'Content-type': 'application/json'
  };
  Map<String, dynamic> body = {
    'name': service.name,
    'role': service.role,
    'price': service.price,
  };
  http.Response response;

  try {
    response = await http.put('${constants.DEV_API}/services/${service.id}',
      headers: headers, body: jsonEncode(body));
  } catch(_) {
    print(_);
    return constants.ERROR_RESPONSE;
  }
  Map<String, dynamic> output = jsonDecode(response.body);
  output['statusCode'] = response.statusCode;
  return output;
}

Future<List<Service>> getServices() async {

  http.Response response;
  try{
    response = await http.get("http://www.json-generator.com/api/json/get/cjUkMLeZqq?indent=2");
    //response = await http.get('${constants.API}/getServices');
  }catch(_){
    print(_);
    return null;//TODO return an error response
  }
  
  var jsonData = json.decode(response.body);

  List<Service> services = [];

  for (var s in jsonData) {
    var service = Service(
      id: s['service_id'],
      name: s['name'],
      price: s['price'],
      role: s['role']
    );
    services.add(service);
  }

  return services;
}
import 'dart:async';
import 'dart:convert';
import 'package:client/models/providerProfile.dart';
import 'package:client/models/service.dart';
import 'package:client/models/user.dart';
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

Future<List<ProviderProfile>> queryProviderProfile({String query, http.Client client}) async {
  http.Response response;
  try {
    response = client == null ? await http.get("${constants.API}/providers/") : await client.get("${constants.API}/providers/");
    print(response);
  } catch (_) {
    print(_);
    return null; //TODO return an error response
  }

  if (response.statusCode != 200) {
    throw Exception('Failed to Retrieve Profiles from Server');
  } else {
    var jsonData = json.decode(response.body);
    List<ProviderProfile> list = [];
    for (dynamic l in jsonData['provider']) {
      var data = l['data'];
      ProviderProfile _profile = new ProviderProfile();
      _profile.id = l['id'];
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
      list.add(_profile);
    }
    
    return list;
  }
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
      if(data['name'] != null){
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

Future<Appointment> createAppointment(ProviderProfile profile, User user, {http.Client client}) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  final now = DateTime.now();
  final dateString = now.toIso8601String();
  final folderName = dateString.substring(0,dateString.indexOf('T'));
  final time = dateString.substring(dateString.indexOf('T') + 1, dateString.indexOf('T') + 6);
  final start = getStartDate(now.weekday, profile);
  final end = getEndDate(now.weekday, profile);
  Map<String, dynamic> body = {
    'serviceId': profile.id,
    'userId': user.userName,
    'time': time,
  };

  http.Response response;
  try {
    response = await http.post("${constants.API}/providers/${profile.id}/dates/$folderName?startTime=$start&endTime=$end",
    headers: headers, body: jsonEncode(body));
    print(response);
  } catch (e) {
    print(e);
    return null; //TODO return an error response
  }

  var jsonData = jsonDecode(response.body);
  var data = jsonData['provider']['data'];

  return Appointment(serviceID: data['serviceId'], time: data['time'], userID: data['userId']);
}

Future<String> getWaitTime(ProviderProfile profile) async {
  final now = DateTime.now();
  final dateString = now.toIso8601String();
  final folderName = dateString.substring(0,dateString.indexOf('T'));
  final time = dateString.substring(dateString.indexOf('T') + 1, dateString.indexOf('T') + 6);

  var status = inDateRange(getRange(now.weekday, profile), now);

  if (status != null) {
    return status;
  }

  http.Response response;
  try {
    response = await http.get("${constants.API}/providers/${profile.id}/dates/$folderName?time=$time");
    print(response);
  } catch (e) {
    print(e);
    return null; //TODO return an error response
  }

  var jsonData = jsonDecode(response.body);
  List<Appointment> list = [];
  for (var a in jsonData['appointment']) {
    var data = a['data'];
    list.add(Appointment(
      serviceID: data['serviceId'],
      time: data['time'],
      userID: data['userId']
    ));
  }

  if (list.length > 0) {
    var last = list.last.time;
    var diff = getTimeDiff(last, now);
    return renderWaitTime(diff);
  }
  return 'No Wait';
}

getStartDate(int weekday, ProviderProfile profile) {
  switch(weekday) {
    case 1:
      return startTime(profile.availabilities.monday);
    case 2:
      return startTime(profile.availabilities.tuesday);
    case 3:
      return startTime(profile.availabilities.wednesday);
    case 4:
      return startTime(profile.availabilities.thursday);
    case 5:
      return startTime(profile.availabilities.friday);
    case 6:
      return startTime(profile.availabilities.saturday);
    case 7:
      return startTime(profile.availabilities.sunday);
  }
  return null;
}

getRange(int weekday, ProviderProfile profile) {
  switch(weekday) {
    case 1:
      return profile.availabilities.monday;
    case 2:
      return profile.availabilities.tuesday;
    case 3:
      return profile.availabilities.wednesday;
    case 4:
      return profile.availabilities.thursday;
    case 5:
      return profile.availabilities.friday;
    case 6:
      return profile.availabilities.saturday;
    case 7:
      return profile.availabilities.sunday;
  }
  return null;
}

getEndDate(int weekday, ProviderProfile profile) {
  switch(weekday) {
    case 1:
      return endTime(profile.availabilities.monday);
    case 2:
      return endTime(profile.availabilities.tuesday);
    case 3:
      return endTime(profile.availabilities.wednesday);
    case 4:
      return endTime(profile.availabilities.thursday);
    case 5:
      return endTime(profile.availabilities.friday);
    case 6:
      return endTime(profile.availabilities.saturday);
    case 7:
      return endTime(profile.availabilities.sunday);
  }
  return null;
}

DateTime convertTimeStringToDateTime(String time) {
  var lastHR = int.parse(time.split(':')[0]);
  var lastMIN = int.parse(time.split(':')[1]);
  var temp = DateTime.now();
  temp = temp.toLocal();
  temp = DateTime(temp.year, temp.month, temp.day, lastHR, lastMIN, temp.second, temp.millisecond, temp.microsecond);
  return temp;
}

Duration getTimeDiff(String last, DateTime now) {
  var lastHR = int.parse(last.split(':')[0]);
  var lastMIN = int.parse(last.split(':')[1]);
  var temp = DateTime.now();
  temp = temp.toLocal();
  temp = DateTime(temp.year, temp.month, temp.day, lastHR, lastMIN, temp.second, temp.millisecond, temp.microsecond).add(Duration(minutes: 15));
  return now.difference(temp);
}

String renderWaitTime(Duration duration) {
  if (duration.inHours > 0) {
    return '${duration.inHours.abs()} hours';
  }

  return '${duration.inMinutes.abs()} min';
}

String inDateRange(String range, DateTime now) {
  if (range == 'closed') {
    return 'Closed';
  }
  var start = startTime(range);
  var end = endTime(range);
  var sD = convertTimeStringToDateTime(start);
  var eD = convertTimeStringToDateTime(end);
  if (now.difference(sD).isNegative || !now.difference(eD).isNegative) {
    return 'Closed';
  }
  return null;
}

startTime(String combined) {
  return combined.split(' - ')[0];
}

endTime(String combined) {
  return combined.split(' - ')[1];
}
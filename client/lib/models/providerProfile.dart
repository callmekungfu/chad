import 'package:client/models/service.dart';
import 'package:client/models/user.dart';
import 'package:client/services/providerProfile.dart';
import 'package:client/services/providerProfile.dart' as service;
import 'package:flutter/cupertino.dart';

class ProviderProfile {
  String email;
  String companyName;
  String phoneNumber;
  String address;
  String description;
  String id;
  bool liscensed = false;
  Availabilities availabilities = Availabilities();
  List<Service> services = [];

  ProviderProfile({
    this.email,
    this.companyName,
    this.phoneNumber,
    this.address,
    this.description,
    this.id,
    this.liscensed,
  });

  String get searchable {
    var str = '';
    if (this.companyName != null) {
      str += this.companyName + ' ';
    }
    if (this.address != null) {
      str += this.address + ' ';
    }
    final aMap = this.availabilities.toMap();
    str += aMap.toString();
    return str;
  }

  Future<Map<String, dynamic>> create() async {
    return createProviderProfile(this);
  }

  Future<Map<String, dynamic>> update() async {
    return updateProviderProfile(this);
  }

  static Future<ProviderProfile> getProviderProfile(String id) async {
    return service.getProviderProfile(id);
  }

  static Future<List<ProviderProfile>> getProviderProfiles({String query}) async {
    return service.queryProviderProfile();
  }

  Future<Appointment> createAppointment({@required User user}) {
    if (this.id == null) {
      throw ErrorDescription('Provider ID is not defined, cannot create appointments');
    }

    if (user.id == null) {
      throw ErrorDescription('User ID is not defined, cannot ceate appointment');
    }

    service.createAppointment(this, user);
  }
}

class Availabilities {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  Map<String, String> toMap() {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }

  void fromMap(Map<String, String> map) {
    this.monday = map['monday'];
    this.tuesday = map['tuesday'];
    this.wednesday = map['wednesday'];
    this.thursday = map['thursday'];
    this.friday = map['friday'];
    this.saturday = map['saturday'];
    this.sunday = map['sunday'];
  }
}

class Appointment {
  String serviceID;
  String userID; // This is also the patient ID
  String time;

  Appointment({@required this.serviceID, @required this.userID, @required this.time});
}
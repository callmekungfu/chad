import 'package:client/services/providerProfile.dart';
import 'package:client/services/providerProfile.dart' as service;

class ProviderProfile {
  String email;
  String companyName;
  String phoneNumber;
  String address;
  String description;
  String id;
  bool liscensed = false;
  Availabilities availabilities = Availabilities();

  ProviderProfile(
      {String email,
      String companyName,
      String phoneNumber,
      String address,
      String description,
      bool liscensed}) {
    this.companyName = companyName;
    this.phoneNumber = phoneNumber;
    this.address = address;
    this.description = description;
    this.liscensed = liscensed;
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
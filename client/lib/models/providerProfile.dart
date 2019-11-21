import 'package:client/services/providerProfile.dart';
import 'package:client/services/providerProfile.dart' as service;

class ProviderProfile {
  String email;
  String companyName;
  String phoneNumber;
  String address;
  String description;
  bool liscensed = false;

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

  static Future<ProviderProfile> getProviderProfile(String id) async {
    return service.getProviderProfile(id);
  }
}

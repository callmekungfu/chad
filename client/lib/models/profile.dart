import 'package:client/services/profile.dart';

class Profile {
  String userId;
  String companyName;
  String phoneNumber;
  String address;
  String description;
  bool liscensed = false;

  Profile(
      {String userId,
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
    return createProfile(this);
  }

  static Future<Profile> getUserProfile(String userId) async {
    return getProfile(userId);
  }
}

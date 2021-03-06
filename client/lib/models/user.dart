import 'package:client/models/role.dart';
import 'package:client/services/user.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String userName;
  String password;
  String provider;
  Role role;

  Future<Map<String, dynamic>> create() async {
    return createUser(this);
  }
}

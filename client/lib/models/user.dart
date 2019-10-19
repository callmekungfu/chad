import 'package:client/models/role.dart';
import 'package:client/services/user.dart';

class User {
  String firstName;
  String lastName;
  String userName;
  String password;
  Role role;
  String srole;

  Future<Map<String, dynamic>> create() async {
    return createUser(this);
  }
}

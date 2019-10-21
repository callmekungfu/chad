import 'package:client/services/authenticate.dart';

class Credential {
  String userName;
  String password;
  Future<Map<String, dynamic>> login() async {
    return authenticate(this);
  }
}
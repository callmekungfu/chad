import 'package:client/services/service.dart';

class Service {
  String name;
  String role;
  double price;

  Future<Map<String, dynamic>> create() async {
    return createService(this);
  }
}
import 'package:client/services/service.dart';

class Service {
  String id;
  String name;
  String role;
  double price;

  Future<Map<String, dynamic>> create() async {
    return createService(this);
  }
  
  Service(this.serviceId, this.name, this.price, this.role);
}
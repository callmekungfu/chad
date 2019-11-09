import 'package:client/services/service.dart';

class Service {
  String id;
  String name;
  String role;
  double price;

  Future<Map<String, dynamic>> create() async {
    return createService(this);
  }

  void delete() async {
    return deleteService(this); 
  }

  static Future<List<Service>> getServiceList() async {
    return getServices();
  }

  Service({String id, String name, String role, double price}) {
    this.id = id;
    this.name = name;
    this.role = role;
    this.price = price;
  }
  
}
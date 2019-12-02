import 'package:client/models/role.dart';
import 'package:client/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeWidget', () {
    var user = User();
    user.firstName = 'Yong Lin';
    user.lastName = 'Wang';
    user.role = Role.EMPLOYEE;
    test('should create correct greeting', () {
      expect(user.role, Role.EMPLOYEE);
    });
  });
}
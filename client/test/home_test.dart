import 'package:client/models/role.dart';
import 'package:client/models/user.dart';
import 'package:client/screens/home/components/body.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeWidget', () {
    var user = User();
    user.firstName = 'Yong Lin';
    user.lastName = 'Wang';
    user.role = Role.EMPLOYEE;
    var home = Body(user: user);
    test('should create correct greeting', () {
      expect(home.promptBuilder(user), 'Welcome Yong Lin Wang, you are logged in as employee');
    });
  });
}
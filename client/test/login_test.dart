// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:client/models/role.dart';
import 'package:client/screens/login/components/body.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginWidget', () {
    var login = Body().createState();
    group('Validators', () {
      test('should validate email', () {
        expect(login.validateEmail(''), 'Email is Required');
        expect(login.validateEmail('this_is_not_a_email'), 'Invalid Email');
        expect(login.validateEmail('email@email.ca'), null);
      });

      test('should validate password', () {
        expect(login.validatePassword(''), 'Please enter a password.');
        expect(login.validatePassword('tooshrt'), 'Password must contain more than 8 characters.');
        expect(login.validatePassword('goodpass'), null);
      });
    });
    group('Helpers', () {
      test('should convert role to enum', () {
        expect(login.convertToRole('PATIENT'), Role.PATIENT);
        expect(login.convertToRole('EmPlOyEe'), Role.EMPLOYEE);
        expect(login.convertToRole('ADMINISTRATOR'), Role.ADMINISTRATOR);
      });
    });
  });
  
}

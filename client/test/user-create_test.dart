import 'package:client/screens/admin/components/body.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserCreationWidget', () {
    var form = Body().createState();
    group('Validators', () {
      test('should validate email', () {
        expect(form.validateEmail('this_is_not_a_email'), 'Please enter a valid email');
        expect(form.validateEmail('email@email.ca'), null);
      });

      test('should fail', () {
        expect(true, false);
      });
    });
  });
}
import 'package:client/models/service.dart';
import 'package:client/screens/service-management/components/service-form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServiceManagementWidget', () {
    var form = ServiceFormWidget().createState();

    group('Validators', () {
      test('should validate empty fields', () {
        expect(form.validateEmpty('', 'Empty'), 'Empty');
        expect(form.validateEmpty('something', 'Empty'), null);
      });
    });

    group('Helpers', () {
      test('should change button text accordingly', () {
        expect(form.buttonText(null), 'Create Service');
        expect(form.buttonText(Service()), 'Modify Service');
      });
    });
  });
}
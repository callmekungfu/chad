import 'package:client/screens/employee-hub-view/components/body.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Service Provider Profile Page', (){
    var page = Body(user: null,).createState();
    test('get start date from combination', (){
      const testCase = '11:30 - 12:30';
      expect(page.startTime(testCase), '11:30');
    });
    test('get start date from combination', (){
      const testCase = '11:30 - 12:30';
      expect(page.endTime(testCase), '12:30');
    });
  });
}
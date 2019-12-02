import 'package:client/models/providerProfile.dart';
import 'package:client/models/user.dart';
import 'package:client/screens/patient-hub-view/components/provider-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:client/constants.dart' as constants;

import 'data.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Provider Profile Screen', () {
    var state = ProviderProfileWidget(profile: null,).createState();
    test('should capitalize words', () {
      expect(state.capitalize('monday'), 'Monday');
    });

    test('should build correct status tag', () {
      expect((state.generateStatusTag(true) as Text).data, 'Licensed');
      expect((state.generateStatusTag(false) as Text).data, 'Not Licensed');
    });
  });
  
  group('Provider Profile Model', () {
    group('getProviderProfiles()', () {
      test('should parse profile data', () async {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response(PROVIDER_PROFILES_BODY, 200));
        var returnData = await ProviderProfile.getProviderProfiles(client: client);
        expect(returnData.length, 4);
      });

      test('should parse profile details', () async {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response(PROVIDER_PROFILES_BODY, 200));
        var returnData = await ProviderProfile.getProviderProfiles(client: client);
        expect(returnData[0].companyName, 'Southbank Healthcare Center');
      });

      test('should parse profile details 1', () async {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response(PROVIDER_PROFILES_BODY, 200));
        var returnData = await ProviderProfile.getProviderProfiles(client: client);
        expect(returnData[1].address, '1980 Baseline Road, Ottawa, ON K2C 0C6');
      });

      test('should parse profile details 2', () async {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response(PROVIDER_PROFILES_BODY, 200));
        var returnData = await ProviderProfile.getProviderProfiles(client: client);
        expect(returnData[2].phoneNumber, '6135212391');
      });

      test('should parse week days', () async {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response(PROVIDER_PROFILES_BODY, 200));
        var returnData = await ProviderProfile.getProviderProfiles(client: client);
        expect(returnData[0].availabilities.toMap(), {
          'monday': '08:30 - 20:00',
          'tuesday': '08:30 - 20:00',
          'wednesday': '08:30 - 20:00',
          'thursday': '08:30 - 20:00',
          'friday': '08:30 - 20:00',
          'saturday': '09:00 - 17:30',
          'sunday': '09:00 - 17:30',
        });
      });

      test('should fail parsing with error', () {
        final client = MockClient();
        when(client.get('${constants.API}/providers/'))
          .thenAnswer((_) async => http.Response('', 500));
        expect(ProviderProfile.getProviderProfiles(client: client), throwsException);
      });
    });
    group('createAppointment()', () {
      test('should require provider ID', () {
        expect(ProviderProfile().createAppointment(user: null), null);
      });
      test('should require provider ID', () {
        expect(ProviderProfile(id: 'abc').createAppointment(user: User()), null);
      });
    });

  });
}
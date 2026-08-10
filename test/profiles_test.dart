import 'package:flutter_test/flutter_test.dart';
import 'package:moe_flutter_profiles/moe_flutter_profiles.dart';

void main() {
  group('ProfileModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 1,
        'user_id': 10,
        'bio': 'Software developer',
        'address': 'Jl. Merdeka No. 1',
        'city': 'Jakarta',
        'province': 'DKI Jakarta',
        'postal_code': '10110',
        'country': 'Indonesia',
        'date_of_birth': '1990-01-15T00:00:00.000',
        'gender': 'male',
        'occupation': 'Developer',
        'website': 'https://example.com',
        'whatsapp': '081234567890',
      };

      final profile = ProfileModel.fromJson(json);

      expect(profile.id, equals(1));
      expect(profile.userId, equals(10));
      expect(profile.bio, equals('Software developer'));
      expect(profile.address, equals('Jl. Merdeka No. 1'));
      expect(profile.city, equals('Jakarta'));
      expect(profile.province, equals('DKI Jakarta'));
      expect(profile.postalCode, equals('10110'));
      expect(profile.country, equals('Indonesia'));
      expect(profile.dateOfBirth, isNotNull);
      expect(profile.dateOfBirth!.year, equals(1990));
      expect(profile.gender, equals('male'));
      expect(profile.occupation, equals('Developer'));
      expect(profile.website, equals('https://example.com'));
      expect(profile.whatsapp, equals('081234567890'));
    });

    test('toJson round-trips correctly', () {
      const profile = ProfileModel(
        userId: 1,
        bio: 'Test bio',
        city: 'Bandung',
      );

      final json = profile.toJson();

      expect(json['user_id'], equals(1));
      expect(json['bio'], equals('Test bio'));
      expect(json['city'], equals('Bandung'));
    });

    test('copyWith updates fields', () {
      const profile = ProfileModel(
        userId: 1,
        bio: 'Old bio',
        city: 'Jakarta',
      );

      final updated = profile.copyWith(
        bio: 'New bio',
        city: 'Bandung',
      );

      expect(updated.userId, equals(1));
      expect(updated.bio, equals('New bio'));
      expect(updated.city, equals('Bandung'));
    });

    test('nullable fields default to null', () {
      const profile = ProfileModel(userId: 1);

      expect(profile.id, isNull);
      expect(profile.bio, isNull);
      expect(profile.address, isNull);
      expect(profile.city, isNull);
      expect(profile.dateOfBirth, isNull);
    });
  });

  group('UpdateProfileRequest', () {
    test('toJson only includes non-null fields', () {
      const request = UpdateProfileRequest(
        bio: 'New bio',
        city: 'Jakarta',
      );

      final json = request.toJson();

      expect(json['bio'], equals('New bio'));
      expect(json['city'], equals('Jakarta'));
      expect(json.containsKey('address'), isFalse);
      expect(json.containsKey('gender'), isFalse);
    });

    test('empty request produces empty map', () {
      const request = UpdateProfileRequest();

      expect(request.toJson(), isEmpty);
    });

    test('dateOfBirth serializes to ISO8601', () {
      final date = DateTime(1990, 1, 15);
      final request = UpdateProfileRequest(dateOfBirth: date);

      final json = request.toJson();

      expect(json['date_of_birth'], equals(date.toIso8601String()));
    });
  });

  group('MoeProfilesConfig', () {
    test('default values', () {
      const config = MoeProfilesConfig();

      expect(config.profileEndpoint, equals('/profile'));
      expect(config.avatarEndpoint, equals('/profile/avatar'));
      expect(config.enableAvatarUpload, isTrue);
    });

    test('custom values', () {
      const config = MoeProfilesConfig(
        profileEndpoint: '/api/user/profile',
        avatarEndpoint: '/api/user/avatar',
        enableAvatarUpload: false,
      );

      expect(config.profileEndpoint, equals('/api/user/profile'));
      expect(config.avatarEndpoint, equals('/api/user/avatar'));
      expect(config.enableAvatarUpload, isFalse);
    });
  });
}

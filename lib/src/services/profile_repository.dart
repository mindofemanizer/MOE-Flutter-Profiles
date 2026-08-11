import 'package:dio/dio.dart';

import 'package:moe_flutter_core/moe_flutter_core.dart';
import 'package:moe_flutter_profiles/src/config/profiles_config.dart';
import 'package:moe_flutter_profiles/src/models/profile_dto.dart';
import 'package:moe_flutter_profiles/src/models/profile_model.dart';

/// Repository for profile operations.
///
/// All methods return [AppResult] — never throws to UI.
class ProfileRepository {
  final Dio _dio;
  final MoeProfilesConfig _config;

  ProfileRepository(this._dio, this._config);

  /// Get current user's profile.
  Future<AppResult<ProfileModel>> getProfile() async {
    try {
      final response = await _dio.get(_config.profileEndpoint);
      final data = response.data as Map<String, dynamic>;
      var profile = ProfileModel.fromJson(data);

      final kvEndpoint = _config.keyValueProfilesEndpoint;
      if (kvEndpoint != null && kvEndpoint.isNotEmpty) {
        final kvResult = await getKeyValueProfiles();
        if (kvResult case Ok(:final data)) {
          profile = profile.copyWith(keyValueProfiles: data);
        }
      }

      return Ok(profile);
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }

  /// Update current user's profile.
  Future<AppResult<ProfileModel>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response = await _dio.put(
        _config.profileEndpoint,
        data: request.toJson(),
      );
      final data = response.data as Map<String, dynamic>;
      return Ok(ProfileModel.fromJson(data));
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }

  /// Upload avatar image (multipart).
  Future<AppResult<String>> uploadAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        _config.avatarFieldName: await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post(
        _config.avatarEndpoint,
        data: formData,
      );
      final data = response.data as Map<String, dynamic>;
      final avatarUrl = data['avatar_url'] as String? ??
          data['avatar'] as String? ??
          (data['user'] is Map<String, dynamic>
              ? (data['user'] as Map<String, dynamic>)['avatar'] as String?
              : null);
      if (avatarUrl == null) {
        return const Err(AppFailure(
          type: FailureType.unknown,
          message: 'Avatar URL tidak ditemukan di response.',
        ));
      }
      return Ok(avatarUrl);
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }

  /// Delete avatar.
  Future<AppResult<void>> deleteAvatar() async {
    try {
      await _dio.delete(_config.avatarEndpoint);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }

  /// Get key-value profiles map.
  Future<AppResult<Map<String, dynamic>>> getKeyValueProfiles() async {
    final endpoint = _config.keyValueProfilesEndpoint;
    if (endpoint == null || endpoint.isEmpty) {
      return const Err(AppFailure(
        type: FailureType.unknown,
        message: 'keyValueProfilesEndpoint belum dikonfigurasi.',
      ));
    }

    try {
      final response = await _dio.get(endpoint);
      final data = response.data as Map<String, dynamic>;
      final profiles = data['profiles'];
      if (profiles is Map<String, dynamic>) {
        return Ok(profiles);
      }
      return Ok(Map<String, dynamic>.from(data));
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }

  /// Set one key-value profile entry.
  Future<AppResult<Map<String, dynamic>>> setProfileKey(
    SetProfileKeyRequest request,
  ) async {
    final endpoint = _config.keyValueProfilesEndpoint;
    if (endpoint == null || endpoint.isEmpty) {
      return const Err(AppFailure(
        type: FailureType.unknown,
        message: 'keyValueProfilesEndpoint belum dikonfigurasi.',
      ));
    }

    try {
      final response = await _dio.put(endpoint, data: request.toJson());
      final data = response.data as Map<String, dynamic>;
      final profiles = data['profiles'];
      if (profiles is Map<String, dynamic>) {
        return Ok(profiles);
      }
      return Ok(Map<String, dynamic>.from(data));
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(AppFailure(
        type: FailureType.unknown,
        message: e.toString(),
      ));
    }
  }
}

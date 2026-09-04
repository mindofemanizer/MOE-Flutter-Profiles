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
  ///
  /// Backend: `GET /profile` → `{profile}`.
  Future<AppResult<ProfileModel>> getProfile() async {
    try {
      final response = await _dio.get(_config.profileEndpoint);
      final data = response.data as Map<String, dynamic>;
      // Handle multiple response formats:
      // - { "profile": {...} }
      // - { "user": {...} }  (from GET /me)
      // - raw profile object
      final profileJson = data.containsKey('profile')
          ? data['profile'] as Map<String, dynamic>
          : data.containsKey('user')
              ? data['user'] as Map<String, dynamic>
              : data;
      return Ok(ProfileModel.fromJson(profileJson));
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.unknown,
          message: e.toString(),
        ),
      );
    }
  }

  /// Update current user's profile.
  ///
  /// Backend: `PUT /profile` → `{profile}`.
  Future<AppResult<ProfileModel>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response =
          await _dio.put(_config.profileEndpoint, data: request.toJson());
      final data = response.data as Map<String, dynamic>;
      final profileJson = data.containsKey('profile')
          ? data['profile'] as Map<String, dynamic>
          : data;
      return Ok(ProfileModel.fromJson(profileJson));
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.unknown,
          message: e.toString(),
        ),
      );
    }
  }

  /// Upload avatar image.
  ///
  /// Backend: `POST /profile/avatar` (multipart) → `{avatar_url}`.
  Future<AppResult<String>> uploadAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post(
        _config.avatarEndpoint,
        data: formData,
      );
      final data = response.data as Map<String, dynamic>;
      final avatarUrl =
          data['avatar_url'] as String? ?? data['avatar'] as String?;
      if (avatarUrl == null) {
        return const Err(
          AppFailure(
            type: FailureType.unknown,
            message: 'Avatar URL tidak ditemukan di response.',
          ),
        );
      }
      return Ok(avatarUrl);
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.unknown,
          message: e.toString(),
        ),
      );
    }
  }

  /// Delete avatar.
  ///
  /// Backend: `DELETE /profile/avatar`.
  Future<AppResult<void>> deleteAvatar() async {
    try {
      await _dio.delete(_config.avatarEndpoint);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(mapDioErrorToFailure(e));
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.unknown,
          message: e.toString(),
        ),
      );
    }
  }
}

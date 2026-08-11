import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moe_flutter_core/moe_flutter_core.dart';
import 'package:moe_flutter_profiles/src/config/profiles_config.dart';
import 'package:moe_flutter_profiles/src/models/profile_dto.dart';
import 'package:moe_flutter_profiles/src/models/profile_model.dart';
import 'package:moe_flutter_profiles/src/services/profile_repository.dart';

/// State for profile operations.
sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  const ProfileLoaded(this.profile);
}

final class ProfileError extends ProfileState {
  final AppFailure failure;
  const ProfileError(this.failure);
}

/// Notifier for profile data.
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileInitial());

  Future<void> loadProfile() async {
    state = const ProfileLoading();

    final result = await _repository.getProfile();

    switch (result) {
      case Ok(:final data):
        state = ProfileLoaded(data);
      case Err(:final failure):
        state = ProfileError(failure);
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    final previous = state;
    state = const ProfileLoading();

    final result = await _repository.updateProfile(request);

    switch (result) {
      case Ok(:final data):
        final merged = previous is ProfileLoaded
            ? data.copyWith(
                keyValueProfiles:
                    data.keyValueProfiles ?? previous.profile.keyValueProfiles,
              )
            : data;
        state = ProfileLoaded(merged);
      case Err(:final failure):
        state = ProfileError(failure);
    }
  }

  Future<AppResult<String>> uploadAvatar(String filePath) async {
    final result = await _repository.uploadAvatar(filePath);
    if (result is Ok<String>) {
      await loadProfile();
    }
    return result;
  }

  Future<void> deleteAvatar() async {
    await _repository.deleteAvatar();
    await loadProfile();
  }

  Future<AppResult<Map<String, dynamic>>> setProfileKey({
    required String key,
    dynamic value,
  }) async {
    final result = await _repository.setProfileKey(
      SetProfileKeyRequest(key: key, value: value),
    );

    if (result case Ok(:final data)) {
      final current = state;
      if (current is ProfileLoaded) {
        state = ProfileLoaded(
          current.profile.copyWith(keyValueProfiles: data),
        );
      }
    }

    return result;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(profilesConfigProvider);
  return ProfileRepository(dio, config);
});

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref.watch(profileRepositoryProvider));
});

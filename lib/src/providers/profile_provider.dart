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
///
/// Loads profile on init, supports update + avatar upload.
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileInitial());

  /// Load profile from backend.
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

  /// Update profile.
  Future<void> updateProfile(UpdateProfileRequest request) async {
    final result = await _repository.updateProfile(request);

    switch (result) {
      case Ok(:final data):
        state = ProfileLoaded(data);
      case Err(:final failure):
        state = ProfileError(failure);
    }
  }

  /// Upload avatar.
  Future<AppResult<String>> uploadAvatar(String filePath) async {
    return await _repository.uploadAvatar(filePath);
  }

  /// Delete avatar.
  Future<void> deleteAvatar() async {
    await _repository.deleteAvatar();
    await loadProfile();
  }
}

/// Provider for ProfileRepository.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(profilesConfigProvider);
  return ProfileRepository(dio, config);
});

/// Provider for ProfileNotifier.
final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref.watch(profileRepositoryProvider));
});

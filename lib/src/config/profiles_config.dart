import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Configuration for MOE Profiles package.
class MoeProfilesConfig {
  final String profileEndpoint;
  final String avatarEndpoint;
  final String avatarFieldName;
  final String? keyValueProfilesEndpoint;
  final bool enableAvatarUpload;

  const MoeProfilesConfig({
    this.profileEndpoint = '/profile',
    this.avatarEndpoint = '/profile/avatar',
    this.avatarFieldName = 'avatar',
    this.keyValueProfilesEndpoint,
    this.enableAvatarUpload = true,
  });
}

final profilesConfigProvider = Provider<MoeProfilesConfig>((ref) {
  return MoeProfiles.config;
});

class MoeProfiles {
  static late MoeProfilesConfig _config;

  static void setup({required MoeProfilesConfig config}) {
    _config = config;
  }

  static MoeProfilesConfig get config => _config;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Configuration for MOE Profiles package.
class MoeProfilesConfig {
  final String profileEndpoint;
  final String avatarEndpoint;
  final bool enableAvatarUpload;

  const MoeProfilesConfig({
    this.profileEndpoint = '/profile',
    this.avatarEndpoint = '/profile/avatar',
    this.enableAvatarUpload = true,
  });
}

/// Provider for profiles config.
final profilesConfigProvider = Provider<MoeProfilesConfig>((ref) {
  return MoeProfiles.config;
});

/// Setup function — call in main() before runApp().
///
/// ```dart
/// void main() {
///   MoeCore.setup(envConfig: EnvConfig.fromEnvironment());
///   MoeAuth.setup(config: MoeAuthConfig());
///   MoeProfiles.setup(
///     config: MoeProfilesConfig(
///       profileEndpoint: '/api/profile',
///     ),
///   );
///   runApp(const ProviderScope(child: MyApp()));
/// }
/// ```
class MoeProfiles {
  static late MoeProfilesConfig _config;

  static void setup({required MoeProfilesConfig config}) {
    _config = config;
  }

  static MoeProfilesConfig get config => _config;
}

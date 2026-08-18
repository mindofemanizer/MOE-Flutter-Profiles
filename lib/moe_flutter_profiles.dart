/// Barrel file — public API for moe_flutter_profiles.
///
/// Consumer only imports:
/// ```dart
/// import 'package:moe_flutter_profiles/moe_flutter_profiles.dart';
/// ```
library;

// Config
export 'src/config/profiles_config.dart';

// Models
export 'src/models/profile_model.dart';
export 'src/models/profile_dto.dart';

// Services
export 'src/services/profile_repository.dart';

// Providers
export 'src/providers/profile_provider.dart';

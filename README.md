# MOE-Flutter-Profiles

Profiles package for MOE Flutter ecosystem — user profile CRUD, avatar upload, preferences.

## Installation

```yaml
dependencies:
  moe_flutter_profiles:
    git:
      url: https://github.com/mindofemanizer/MOE-Flutter-Profiles.git
      ref: main
```

## Usage

### Setup

```dart
import 'package:moe_flutter_core/moe_flutter_core.dart';
import 'package:moe_flutter_auth/moe_flutter_auth.dart';
import 'package:moe_flutter_profiles/moe_flutter_profiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  MoeCore.setup(envConfig: EnvConfig.fromEnvironment());
  MoeAuth.setup(config: MoeAuthConfig());
  MoeProfiles.setup(
    config: MoeProfilesConfig(
      profileEndpoint: '/profile',
      avatarEndpoint: '/profile/avatar',
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}
```

### Load Profile

```dart
final profileState = ref.watch(profileProvider);

switch (profileState) {
  case ProfileInitial():
    // initial state
  case ProfileLoading():
    // show loading
  case ProfileLoaded(:final profile):
    // show profile data
    Text(profile.bio ?? 'No bio');
    Text(profile.city ?? 'No city');
  case ProfileError(:final failure):
    // show error
}

// trigger load
ref.read(profileProvider.notifier).loadProfile();
```

### Update Profile

```dart
await ref.read(profileProvider.notifier).updateProfile(
  UpdateProfileRequest(
    bio: 'Updated bio',
    city: 'Jakarta',
    gender: 'male',
  ),
);
```

### Upload Avatar

```dart
final result = await ref.read(profileProvider.notifier).uploadAvatar(
  '/path/to/image.jpg',
);

switch (result) {
  case Ok(:final data):
    // data = avatar URL
  case Err(:final failure):
    // show error
}
```

## What's Included

| Module | Description |
|--------|-------------|
| `ProfileModel` | Extended profile data (bio, address, social media, etc.) |
| `UpdateProfileRequest` | Partial update DTO |
| `ProfileRepository` | API calls with AppResult |
| `ProfileNotifier` | State management |
| `MoeProfilesConfig` | Configurable endpoints |

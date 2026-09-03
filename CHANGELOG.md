# Changelog

## 1.0.1 — 2026-09-03

### Changed
- Internal pin `moe_flutter_auth` → `v1.0.1` (401-handler fix).

## 1.0.0 — 2026-08-10

### Added
- Initial release
- `ProfileModel` — extended user profile (bio, address, city, province, DOB, gender, occupation, social media, metadata)
- `UpdateProfileRequest` — DTO for partial profile updates
- `ProfileRepository` — getProfile, updateProfile, uploadAvatar, deleteAvatar
- `ProfileNotifier` — state management (initial/loading/loaded/error)
- `MoeProfilesConfig` — configurable endpoints
- `MoeProfiles.setup()` — entry point
- Riverpod providers: `profileProvider`, `profileRepositoryProvider`

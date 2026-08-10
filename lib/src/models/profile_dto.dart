/// DTO for profile update request.
///
/// Only includes nullable fields — backend merges with existing data.
class UpdateProfileRequest {
  final String? bio;
  final String? address;
  final String? city;
  final String? province;
  final String? postalCode;
  final String? country;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? occupation;
  final String? website;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? whatsapp;

  const UpdateProfileRequest({
    this.bio,
    this.address,
    this.city,
    this.province,
    this.postalCode,
    this.country,
    this.dateOfBirth,
    this.gender,
    this.occupation,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.whatsapp,
  });

  Map<String, dynamic> toJson() => {
        if (bio != null) 'bio': bio,
        if (address != null) 'address': address,
        if (city != null) 'city': city,
        if (province != null) 'province': province,
        if (postalCode != null) 'postal_code': postalCode,
        if (country != null) 'country': country,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth!.toIso8601String(),
        if (gender != null) 'gender': gender,
        if (occupation != null) 'occupation': occupation,
        if (website != null) 'website': website,
        if (facebook != null) 'facebook': facebook,
        if (instagram != null) 'instagram': instagram,
        if (twitter != null) 'twitter': twitter,
        if (whatsapp != null) 'whatsapp': whatsapp,
      };
}

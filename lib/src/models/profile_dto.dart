/// DTO for profile update request.
class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? phone;
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
    this.name,
    this.email,
    this.phone,
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
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (bio != null) 'bio': bio,
        if (address != null) 'address': address,
        if (city != null) 'city': city,
        if (province != null) 'province': province,
        if (postalCode != null) 'postal_code': postalCode,
        if (country != null) 'country': country,
        if (dateOfBirth != null)
          'date_of_birth': dateOfBirth!.toIso8601String(),
        if (gender != null) 'gender': gender,
        if (occupation != null) 'occupation': occupation,
        if (website != null) 'website': website,
        if (facebook != null) 'facebook': facebook,
        if (instagram != null) 'instagram': instagram,
        if (twitter != null) 'twitter': twitter,
        if (whatsapp != null) 'whatsapp': whatsapp,
      };
}

/// DTO for MOE Laravel key-value profile write.
class SetProfileKeyRequest {
  final String key;
  final dynamic value;

  const SetProfileKeyRequest({required this.key, this.value});

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}

/// Extended profile model — additional user data beyond basic auth fields.
///
/// Complements [UserModel] from moe_flutter_auth with extended profile data:
/// address, date of birth, gender, occupation, etc.
class ProfileModel {
  final int? id;
  final int userId;
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
  final Map<String, dynamic>? metadata;

  const ProfileModel({
    this.id,
    required this.userId,
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
    this.metadata,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int?,
      userId: (json['user_id'] as int?) ?? 0,
      bio: json['bio'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      province: json['province'] as String?,
      postalCode: json['postal_code'] as String?,
      country: json['country'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      gender: json['gender'] as String?,
      occupation: json['occupation'] as String?,
      website: json['website'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      whatsapp: json['whatsapp'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'user_id': userId,
        'bio': bio,
        'address': address,
        'city': city,
        'province': province,
        'postal_code': postalCode,
        'country': country,
        'date_of_birth': dateOfBirth?.toIso8601String(),
        'gender': gender,
        'occupation': occupation,
        'website': website,
        'facebook': facebook,
        'instagram': instagram,
        'twitter': twitter,
        'whatsapp': whatsapp,
        'metadata': metadata,
      };

  ProfileModel copyWith({
    int? id,
    int? userId,
    String? bio,
    String? address,
    String? city,
    String? province,
    String? postalCode,
    String? country,
    DateTime? dateOfBirth,
    String? gender,
    String? occupation,
    String? website,
    String? facebook,
    String? instagram,
    String? twitter,
    String? whatsapp,
    Map<String, dynamic>? metadata,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      city: city ?? this.city,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      occupation: occupation ?? this.occupation,
      website: website ?? this.website,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      whatsapp: whatsapp ?? this.whatsapp,
      metadata: metadata ?? this.metadata,
    );
  }
}

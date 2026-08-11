/// Extended profile model — user identity + optional extended fields.
class ProfileModel {
  final int? id;
  final int? userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
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
  final Map<String, dynamic>? preferences;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? keyValueProfiles;

  const ProfileModel({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.avatar,
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
    this.preferences,
    this.metadata,
    this.keyValueProfiles,
  });

  String get initial {
    final source = name?.trim();
    if (source != null && source.isNotEmpty) {
      return source[0].toUpperCase();
    }
    if (email != null && email!.isNotEmpty) {
      return email![0].toUpperCase();
    }
    return '?';
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json;
    if (json['user'] is Map<String, dynamic>) {
      data = json['user'] as Map<String, dynamic>;
    } else if (json['profile'] is Map<String, dynamic>) {
      data = json['profile'] as Map<String, dynamic>;
    }

    final userIdRaw = data['user_id'] ?? data['id'];
    final idRaw = data['id'];

    return ProfileModel(
      id: idRaw is int ? idRaw : int.tryParse('$idRaw'),
      userId: userIdRaw is int ? userIdRaw : int.tryParse('$userIdRaw'),
      name: data['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      avatar: data['avatar'] as String? ?? data['avatar_url'] as String?,
      bio: data['bio'] as String?,
      address: data['address'] as String?,
      city: data['city'] as String?,
      province: data['province'] as String?,
      postalCode: data['postal_code'] as String?,
      country: data['country'] as String?,
      dateOfBirth: data['date_of_birth'] != null
          ? DateTime.tryParse(data['date_of_birth'] as String)
          : null,
      gender: data['gender'] as String?,
      occupation: data['occupation'] as String?,
      website: data['website'] as String?,
      facebook: data['facebook'] as String?,
      instagram: data['instagram'] as String?,
      twitter: data['twitter'] as String?,
      whatsapp: data['whatsapp'] as String?,
      preferences: data['preferences'] as Map<String, dynamic>?,
      metadata: data['metadata'] as Map<String, dynamic>?,
      keyValueProfiles: data['profiles'] as Map<String, dynamic>? ??
          json['profiles'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (userId != null) 'user_id': userId,
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (avatar != null) 'avatar': avatar,
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
        if (preferences != null) 'preferences': preferences,
        if (metadata != null) 'metadata': metadata,
        if (keyValueProfiles != null) 'profiles': keyValueProfiles,
      };

  ProfileModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? phone,
    String? avatar,
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
    Map<String, dynamic>? preferences,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? keyValueProfiles,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
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
      preferences: preferences ?? this.preferences,
      metadata: metadata ?? this.metadata,
      keyValueProfiles: keyValueProfiles ?? this.keyValueProfiles,
    );
  }
}

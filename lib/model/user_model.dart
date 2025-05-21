class UserModel {
  final int userId;
  final String email;
  final String? name;
  final String createdAt;
  int? age;
  String? gender;
  double? height;
  double? weight;
  String? goal;
  String? activityLevel;

  UserModel({
    required this.userId,
    required this.email,
    this.name,
    required this.createdAt,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.goal,
    this.activityLevel,
  });

  UserModel copyWith({
    int? userId,
    String? email,
    String? name,
    String? createdAt,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? goal,
    String? activityLevel,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      createdAt: json['created_at'],
      age: json['age'],
      gender: json['gender'],
      height: json['height'] != null
          ? double.parse(json['height'].toString())
          : null,
      weight: json['weight'] != null
          ? double.parse(json['weight'].toString())
          : null,
      goal: json['goal'],
      activityLevel: json['activity_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'created_at': createdAt,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'goal': goal,
      'activity_level': activityLevel,
    };
  }
}

class AuthResponse {
  final UserModel user;
  final String accessToken;
  final String tokenType;

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

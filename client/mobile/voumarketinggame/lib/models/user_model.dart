class User {
  final String playerId;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatarUrl;
  final String birthday;
  final String gender;

  User({
    required this.playerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.birthday,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      playerId: json['playerId'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      avatarUrl: json['avatarUrl'],
      birthday: json['birthday'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'birthday': birthday,
      'gender': gender,
    };
  }
}

import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int followers;
  final int followings;
  final String? imagePath;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imagePath: json['imagePath'],
      followers: json['followers'],
      followings: json['followings'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      imagePath: user.imagePath,
      followers: user.followers,
      followings: user.followings,
    );
  }

  User toEntity() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      imagePath: imagePath,
      followers: followers,
      followings: followings,
    );
  }
}

import '../../../shared/domain/entities/user.dart';

class LoggedInUser extends User {
  const LoggedInUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.imagePath,
    super.followers,
    super.followings,
  });

  static const empty = LoggedInUser(
    id: "1",
    firstName: "firstName",
    lastName: "lastName",
    email: "email",
  );

  List<Object?> get props =>
      [id, firstName, lastName, email, followers, followings, imagePath, email];

  LoggedInUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? imagePath,
    int? followers,
    int? followings,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
    );
  }
}

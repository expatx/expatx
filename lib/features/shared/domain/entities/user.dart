class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int followers;
  final int followings;
  final String? imagePath;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });
}

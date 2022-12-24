class AuthRepository {
  Future<String> login(
    String email,
    String password,
  ) async {
    print("attempting login");
    await Future.delayed(const Duration(seconds: 3));
    print("abc");
    throw "Cant log inn";
  }

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

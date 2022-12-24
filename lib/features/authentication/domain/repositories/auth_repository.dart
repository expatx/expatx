abstract class AuthRepository {
  Future register(
      String firstName, String lastName, String email, String password);
  Future login(String email, String password);
}

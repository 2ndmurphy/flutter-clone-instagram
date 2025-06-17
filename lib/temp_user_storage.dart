// This class is used to temporarily store user credentials
class TempUserStorage {
  static String email = '';
  static String fullName = '';
  static String username = '';
  static String password = '';

  static void clear() {
    email = '';
    fullName = '';
    username = '';
    password = '';
  }
}
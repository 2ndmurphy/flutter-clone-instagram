import '../models/user.dart';

class UserStorage {
  static final List<User> _users = [];

  static void addUser(User user) {
    _users.add(user);
  }

  static List<User> getUsers() {
    return _users;
  }

  static User? findUserByEmail(String email) {
    return _users.firstWhere(
      (u) => u.email == email,
      orElse: () => throw StateError('No user found with email $email'),
    );
  }
}

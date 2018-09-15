class User {
  int id;
  String name;
  String feedback;

  User(this.id, this.name, this.feedback);
}

typedef void GetUsersCallback(List<User> users);

typedef void GetUserCallback(User user);

abstract class UserDataSource {

  void getUsers(GetUsersCallback callback);

  void getUserById(int userId, GetUserCallback callback);

  void saveUser(User user);

  void updateUser(int userId, User user);

  void deleteUser(int userId);

  void deleteUsers();
}

class UserRepository implements UserDataSource {
  List<User> userDatabase;
  static UserRepository userRepository;

  static UserRepository getInstance() {
    if (userRepository == null) {
      userRepository = UserRepository();
    }
    return userRepository;
  }

  UserRepository() {
    userDatabase = [
      User(1, "Hello", "world"),
      User(2, "The", "Flutter Project"),
    ];
  }

  @override
  void deleteUser(int userId) {
    int index = userDatabase.indexWhere((user) => user.id == userId);
    if (index != -1) {
      userDatabase.removeAt(index);
    }
  }

  @override
  void deleteUsers() {
    userDatabase.clear();
  }

  @override
  void getUserById(int userId, GetUserCallback callback) {
    callback(userDatabase.firstWhere((user) => user.id == userId));
  }

  @override
  void getUsers(GetUsersCallback callback) {
    callback(userDatabase.toList(growable: true));
  }

  @override
  void saveUser(User user) {
    user.id = userDatabase.length + 1;
    userDatabase.insert(0, user);
  }

  @override
  void updateUser(int userId, User user) {
    int index = userDatabase.indexWhere((user) => user.id == userId);
    if (index != -1) {
      userDatabase.removeAt(index);
      userDatabase.insert(index, user);
    }
  }
}

class Injection {
  static UserDataSource provideUserRepository() {
    return UserRepository.getInstance();
  }
}

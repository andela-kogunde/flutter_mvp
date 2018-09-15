import 'package:flutter_mvp/data/data.dart';
import 'package:meta/meta.dart';

abstract class BaseViewContract {
  void displayLoading(bool isLoading);

  void noDataAvailable();
}

abstract class FeedbackViewContract implements BaseViewContract {
  void usersAvailable(List<User> users);
}

abstract class FeedbackPresenterContract {
  void loadUsers();

  void deleteUser(int userId);
}

abstract class AddEditFeedbackViewContract implements BaseViewContract {
  void userAvailable(User user);
}

abstract class AddEditFeedbackPresenterContract {
  void loadUser(int userId);

  void saveUser(@required User user);

  void updateUser(int userId, User user);

  void deleteUser(int userId);
}

import 'package:flutter_mvp/app/contract.dart';
import 'package:flutter_mvp/data/data.dart';
import 'package:meta/meta.dart';

class AddEditFeedbackPresenter implements AddEditFeedbackPresenterContract {
  final AddEditFeedbackViewContract view;
  final UserDataSource dataSource;

  AddEditFeedbackPresenter({@required this.view, @required this.dataSource});

  @override
  void loadUser(int userId) {
    view.displayLoading(true);
    dataSource.getUserById(userId, (user) {
      if (user != null) {
        view.userAvailable(user);
      } else {
        view.noDataAvailable();
      }
      view.displayLoading(false);
    });
  }

  @override
  void saveUser(User user) {
    view.displayLoading(true);
    dataSource.saveUser(user);
    view.displayLoading(false);
  }

  @override
  void updateUser(int userId, User user) {
    view.displayLoading(true);
    dataSource.updateUser(userId, user);
    view.displayLoading(false);
  }

  @override
  void deleteUser(int userId) {
    view.displayLoading(true);
    dataSource.deleteUser(userId);
    view.displayLoading(false);
  }
}

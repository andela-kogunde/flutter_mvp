import 'package:flutter_mvp/app/contract.dart';
import 'package:flutter_mvp/data/data.dart';
import 'package:meta/meta.dart';

class FeedbackPresenter implements FeedbackPresenterContract {
  final FeedbackViewContract view;
  final UserDataSource dataSource;

  FeedbackPresenter({@required this.view, @required this.dataSource});

  @override
  void loadUsers() {
    view.displayLoading(true);
    dataSource.getUsers((users) {
      if (users.isNotEmpty) {
        view.usersAvailable(users);
      } else {
        view.noDataAvailable();
      }
      view.displayLoading(false);
    });
  }

  @override
  void deleteUser(int userId) {
    view.displayLoading(true);
    dataSource.deleteUser(userId);
    view.displayLoading(false);
  }
}

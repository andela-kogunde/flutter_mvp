import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/addeditfeedback/view.dart';
import 'package:flutter_mvp/app/contract.dart';
import 'package:flutter_mvp/app/feedback/presenter.dart';
import 'package:flutter_mvp/data/data.dart';

class FeedbackApp extends StatefulWidget {
  String title;
  User user;

  FeedbackApp(this.title);

  @override
  _FeedbackAppState createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp>
    implements FeedbackViewContract {
  FeedbackPresenterContract presenter;
  List<User> _users = [];
  bool _isLoading = false;
  String _message = "Flutter.io MVP Pattern\nNo Feedback Available";

  @override
  void initState() {
    print("return init");
    presenter = FeedbackPresenter(
        view: this, dataSource: Injection.provideUserRepository());
    presenter.loadUsers();
    super.initState();
  }

  Widget appBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget body() {
    return _isLoading
        ? FeedbackWidgets.loadingView()
        : _users.isNotEmpty
            ? FeedbackWidgets.feedbackList(_users, (user) {
                print('You tapped ${user.name}');
                launchAddEditFeedback(
                  "Edit Feedback",
                  user: user,
                );
              })
            : FeedbackWidgets.messageView(_message);
  }

  Widget fab() {
    return FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          launchAddEditFeedback("Create New Feedback");
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: fab(),
    );
  }

  @override
  void displayLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void noDataAvailable() {
    _message = "Flutter.io MVP Pattern\nNo Feedback Available";
  }

  @override
  void usersAvailable(List<User> users) {
    _users = users;
    print("loaded ${users[users.length - 1]}");
  }

  void launchAddEditFeedback(String title, {User user}) async {
    Map result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddEditFeedback(
        title,
        user: user,
      );
    }));
    if (result != null && result.containsKey('saved')) {
      presenter.loadUsers();
    }
  }
}

typedef void UserCallback(User user);

class FeedbackWidgets {
  static ListView feedbackList(List<User> users, UserCallback callback) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          User user = users[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(user.name),
            subtitle: Text(user.feedback),
            onTap: () {
              callback(user);
            },
          );
        });
  }

  static Center loadingView() {
    return Center(child: CircularProgressIndicator());
  }

  static Center messageView(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
    );
  }
}

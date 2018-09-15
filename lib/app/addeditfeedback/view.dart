import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/addeditfeedback/presenter.dart';
import 'package:flutter_mvp/app/contract.dart';
import 'package:flutter_mvp/data/data.dart';
//import '../feedback/view.dart';

class AddEditFeedback extends StatefulWidget {
  String title;
  User user;

  AddEditFeedback(this.title, {this.user});

  @override
  _AddEditFeedbackState createState() => _AddEditFeedbackState();
}

class _AddEditFeedbackState extends State<AddEditFeedback>
    implements AddEditFeedbackViewContract {
  AddEditFeedbackPresenterContract presenter;
  bool _isLoading = false;
  TextEditingController nameController;
  TextEditingController feedbackController;

  @override
  void initState() {
    presenter = AddEditFeedbackPresenter(
        view: this, dataSource: Injection.provideUserRepository());
    if (widget.user != null) {
      presenter.loadUser(widget.user?.id);
    } else {
      nameController = TextEditingController();
      feedbackController = TextEditingController();
    }
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
        : FeedbackWidgets.feedback(nameController, feedbackController, () {
            if (widget.user == null) {
              User user =
                  User(-1, nameController.text, feedbackController.text);
              presenter.saveUser(user);
            } else {
              widget.user.name = nameController.text;
              widget.user.feedback = feedbackController.text;
              presenter.updateUser(widget.user.id, widget.user);
            }
            Navigator.of(context).pop({'saved': true});
          });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  @override
  void displayLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void noDataAvailable() {}

  @override
  void userAvailable(User user) {
    widget.user = user;
    nameController = TextEditingController(text: widget.user.name);
    feedbackController = TextEditingController(text: widget.user.feedback);
  }
}

class FeedbackWidgets {
  static Widget feedback(TextEditingController controller1,
      TextEditingController controller2, VoidCallback callback) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Full Name",
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller2,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Feedback",
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              splashColor: Colors.red[500],
              onPressed: callback,
            ),
          ),
        ],
      ),
    );
  }

  static Center loadingView() {
    return Center(child: CircularProgressIndicator());
  }
}

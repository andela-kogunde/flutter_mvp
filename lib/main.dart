import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/feedback/view.dart';
import 'package:flutter_mvp/app/addeditfeedback/view.dart';

main() {
  runApp(MaterialApp(
    title: "My App",
    theme: ThemeData(accentColor: Colors.redAccent),
    routes: {
      "/": (_) => FeedbackApp("Flutter MVP"),
      "/addedit": (_) => AddEditFeedback("Flutter MVP"),
      "/myapp": (_) => MyApp()
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:contacts/pages/contact/contacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.grey[800],
          accentColor: Colors.grey[800],
          textTheme: TextTheme(bodyText1: TextStyle(), bodyText2: TextStyle())
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: Contacts(),
    );
  }
}

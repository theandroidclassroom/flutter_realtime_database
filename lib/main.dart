import 'package:flutter/material.dart';
import 'package:flutter_database/screens/contacts.dart';
import 'package:flutter_database/screens/add_contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple,
      accentColor: Colors.redAccent),

      title: 'Flutter Database',
      home: Contacts(),
    );
  }
}

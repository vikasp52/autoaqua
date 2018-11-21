import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(AutoAquaApp());

class AutoAquaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoAqua',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(2.0),
        )
      ),
      home: Login(),
    );
  }
}
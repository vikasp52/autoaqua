import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPref{

  SharedPreferences sharedPreferences;

  Future setUserStatus(bool status)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('loginStatus', status);
  }

  Future userStatus(BuildContext context) async {
     sharedPreferences = await SharedPreferences.getInstance();
    bool login = (sharedPreferences.getBool('loginStatus') ?? false);

    if (login) {
       Navigator.of(context).push(HomePage.route());
      print('Login Status $login');
    } else {
       Navigator.of(context).push(Login.route());
      //sharedPreferences.setBool('_login', false);
    }
  }

}
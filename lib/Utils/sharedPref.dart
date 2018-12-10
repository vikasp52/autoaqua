import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPref{

  SharedPreferences sharedPreferences;

  //Mark the user status as true or false
  Future setUserStatus(bool status)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('loginStatus', status);
  }

  //Clear the sharedPreferences on logout
  Future clearUserStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('loginStatus');
  }

  //Set the user token
   Future setToken(String userToken)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userToken', userToken);
  }

  //Get the user token
  Future getToken()async{
    sharedPreferences = await SharedPreferences.getInstance();
    String tokenId = sharedPreferences.getString('userToken'??false);
    print(tokenId);
    return tokenId;
  }

  // Get the user status
  Future userStatus(BuildContext context) async {
     sharedPreferences = await SharedPreferences.getInstance();
    bool login = (sharedPreferences.getBool('loginStatus') ?? false);

    if (login) {
       Navigator.of(context).pushReplacement(HomePage.route());
      print('Login Status $login');
    } else {
       Navigator.of(context).pushReplacement(Login.route());
      //sharedPreferences.setBool('_login', false);
    }
  }

}
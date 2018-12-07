import 'dart:convert';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      SharedPref().userStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Image.asset(
          "Images/AutoAquaLogo.png",
          height: 170.0,
          width: 170.0,
        ),
      ),
    );
  }
}


class Login extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Login(),
    );
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  var loginForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("Images/backgroundImage.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: loginForm,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            "Images/AutoAquaLogo.png",
                            height: 170.0,
                            width: 170.0,
                          ),
                          Text(
                            "SMART \n IRRIGATION + FERTIGATION + CLIMATE \n CONTROLLER",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: _userNameController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter the username.";
                              }
                            },
                            decoration: new InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "Username"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter the password.";
                              }
                            },
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          MaterialButton(
                              textColor: Colors.white,
                              color: Color.fromRGBO(0, 84, 179, 1.0),
                              child: new Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              splashColor: Colors.amber,
                              onPressed: () {
                                if (loginForm.currentState.validate()) {
                                  _userValidation();
                                } else {
                                  showColoredToast("There is some problem with login");
                                }
                              }),
                          FlatButton(
                              onPressed: null,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Powered By",
                            style: TextStyle(color: Colors.black),
                          ),
                          //jjlogo
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                            child: Image.asset(
                              "Images/jjlogo.png",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )), /*new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("Images/backgroundImage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Text("Vikas")) */ /* add child content content here */ /*,
      ),*/
    );
  }

  void _userValidation() async {
    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/login";

    var client = new http.Client();
    client.post(url, body: {"email": _userNameController.text, "password": _passwordController.text}).then((response) {
      print("Program Response status: ${response.statusCode}");
      print("Program Response body: ${response.body}");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        var jsonData = LoginModel.fromJson(json.decode(response.body));
        print("Status is ${jsonData.message}");
        print("jsonData is ${jsonData.api_token}");
        if (jsonData.status == "success"){
            SharedPref().setUserStatus(true);

          print(SharedPref().setUserStatus(true));
          Navigator.of(context).push(HomePage.route());
            //sharedPreferences.setBool('loginStatus', true);
        } else {
          // If that call was not successful, throw an error.
          showColoredToast(jsonData.message);
        }
      } else {
        // If that call was not successful, throw an error.
        showColoredToast("Please enter the valid username or password.");
        throw Exception('Failed to load post');
      }
    });
  }
}

class LoginModel {
  final String status;
  final String message;
  final bool success;
  final String api_token;

  LoginModel({this.status, this.message, this.success, this.api_token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      success: json['success'],
        api_token:json['api_token'],
    );
  }
}

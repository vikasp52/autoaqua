import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final TextEditingController _UserNameControler =
  new TextEditingController();
  final TextEditingController _PasswordControler=
  new TextEditingController();

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
              padding: const EdgeInsets.only(top: 50.0),
              child: new Column(
                children: <Widget>[
                  Image.asset("Images/AutoAquaLogo.png",
                    height: 150.0,
                    width: 150.0,),
                  new Form(
                      child: new Container(
                          padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 70.0),
                          child: new Column(
                            children: <Widget>[
                              new TextFormField(
                                controller: _UserNameControler,
                                decoration: new InputDecoration(
                                    prefixIcon: Icon(Icons.email, color: Colors.black,),
                                    hintText: "E-mail"
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              new TextFormField(
                                controller: _PasswordControler,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(Icons.lock, color: Colors.black,),
                                  hintText: "Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              new MaterialButton(
                                  textColor: Colors.blue,
                                  color: Colors.white,
                                  child: new Text("Login", style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                  splashColor: Colors.amber,
                                  onPressed: () {
                                    _UserValidation();
                                  }),
                              FlatButton(onPressed: null,
                                  child: Text("Forgot Password?", style: TextStyle(
                                      color: Colors.black
                                  ),))
                            ],
                          ))
                  )
                ],
              ),
            ),
          ],
        ),
      ),/*new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("Images/backgroundImage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Text("Vikas")) *//* add child content content here *//*,
      ),*/
    );
  }

  void _UserValidation() {

    Navigator.of(context).push(HomePage.route());
    /*if(_UserNameControler.text == "v@v.com" && _PasswordControler.text == "12345"){
      Navigator.of(context).push(HomePage.route());
    }else{
      showColoredToast();
    }*/
  }

  void showColoredToast() {
    Fluttertoast.showToast(
        msg: "Please enter the valid username or password!",
        toastLength: Toast.LENGTH_SHORT,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff'
    );
  }

}

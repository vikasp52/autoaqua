import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _userNameController =
  new TextEditingController();
  final TextEditingController _passwordController=
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
              padding: const EdgeInsets.all(40.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("Images/AutoAquaLogo.png",
                          height: 150.0,
                          width: 150.0,),
                        Text("SMART \n IRRIGATION + FERTIGATION + CLIMATE \n CONTROLLER",
                          textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black
                          ),),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _userNameController,
                          decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email, color: Colors.black,),
                              hintText: "Username"
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: Colors.black,),
                            hintText: "Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0,),
                        MaterialButton(
                            textColor: Colors.white,
                            color: Color.fromRGBO(0, 84, 179, 1.0),
                            child: new Text("Login", style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            splashColor: Colors.amber,
                            onPressed: () {
                              _userValidation();
                            }),
                        FlatButton(onPressed: null,
                            child: Text("Forgot Password?", style: TextStyle(
                                color: Colors.black
                            ),)),
                        SizedBox(height: 20.0,),
                        Text("Powered By",style: TextStyle(
                            color: Colors.black
                        ),),
                        //jjlogo
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,10.0),
                          child: Image.asset("Images/jjlogo.png",),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
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

  void _userValidation() {

    Navigator.of(context).push(HomePage.route());
    /*if(_UserNameControler.text == "v@v.com" && _PasswordControler.text == "12345"){
      Navigator.of(context).push(HomePage.route());
    }else{
      showColoredToast("Please enter valid username and password");
    }*/
  }

}

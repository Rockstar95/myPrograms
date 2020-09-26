import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  void show_Error(String errmsg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errmsg),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  void check_Authentication() {
    _firebaseAuth.onAuthStateChanged.listen((user) {
      if(user != null) {
        Navigator.pushReplacementNamed(context, "/Home");
        //print("Not Null");
      }
      else {
        //print("Null");
      }
    });
  }

  void sign_Up() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: _email.trim(), password: _password.trim());
        User user = result.user;

        if(user != null) {
          await user.updateProfile(displayName: _name, photoURL: null);
        }

        check_Authentication();
      }
      catch(e) {
        show_Error(e.toString());
      }
    }
  }

  void navigate_To_Sign_In() {
    Navigator.pushReplacementNamed(context, "/SignIn");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_Authentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(//color: Colors.lightBlueAccent,
        child: Center(
          child: ListView(
            children: [
              Container(//color: Colors.green,
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0 ),
                child: Image(image: AssetImage("assets/logo.png"),height: 200, width: 200,),
              ),
              Container(//color: Colors.grey,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(//color: Colors.redAccent,
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty ? "Required" : null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                          ),
                          onChanged: (val) {
                            _name = val;
                          },
                        ),
                      ),
                      Container(//color: Colors.redAccent,
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty ? "Required" : null;
                          },
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                          ),
                          onChanged: (val) {
                            _email = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty ? "Required" : null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                          ),
                          onChanged: (val) {
                            _password = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: RaisedButton(
                          onPressed: () {
                            sign_Up();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigate_To_Sign_In,
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

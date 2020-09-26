import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_signup_app/home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String name, email, mobile, collegeName;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoVAlidate=false;

  void _sendToNextScreen() {
    if(_formKey.currentState.validate()) {
      //Saves a GlobleKey
      _formKey.currentState.save();

      //Send To Next Screen
      Navigator.push(context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(
            key: _formKey,
            name: name,
            email: email,
            collegeName: collegeName,
            mobile: mobile,
          ),
        )
      );
    }
    else {
      setState(() {
        _autoVAlidate=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Enter Name";
                      }
                      else {
                        return null;
                      }
                    },  
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                    onSaved: (val) {
                      name=val;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextFormField(
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Enter Email";
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    onSaved: (val) {
                      email=val;
                    },
                  ),
                ),ListTile(
                  leading: Icon(Icons.mobile_screen_share),
                  title: TextFormField(
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Enter Mobile";
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Mobile",
                    ),
                    onSaved: (val) {
                      mobile=val;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.school),
                  title: TextFormField(
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Enter College";
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "College",
                    ),
                    onSaved: (val) {
                      collegeName=val;
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                ButtonTheme(
                  height: 40.0,
                  minWidth: 200.0,
                  child: RaisedButton(
                    onPressed: _sendToNextScreen,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

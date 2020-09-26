import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  bool isSignedIn = false;

  void check_Authentication() {
    _firebaseAuth.onAuthStateChanged.listen((user) {
      if(user == null) {
        Navigator.pushReplacementNamed(this.context, "/SignIn");
        //print("Null");
      }
      else {
        //print("Not Null");
        this.getUser();
      }
    });
  }

  void getUser() async {
     User user = await _firebaseAuth.currentUser;
     //Issue  https://github.com/flutter/flutter/issues/19746
     await user?.reload();
     user = await _firebaseAuth.currentUser;

     if(user!=null) {
       setState(() {
         this._user = user;
         this.isSignedIn = true;
       });
     }
  }

  void signOut() async {
    _firebaseAuth.signOut();
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
        title: Text("Home"),
        actions: [

        ],
      ),
      body: Container(
        child: Center(
          child: !isSignedIn
          ? CircularProgressIndicator(strokeWidth: 5.0,)
          : Column(
            children: [
              Container(
                padding: EdgeInsets.all(50.0),
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  "Hello ${_user.displayName}, you are logged in as ${_user.email}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Sign Out", style: TextStyle(color: Colors.white, fontSize: 20.0,),),
                  onPressed: signOut,
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

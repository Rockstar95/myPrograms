import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/signIn.dart';
import 'package:firebaselogin/signUp.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/SignIn",
      routes: <String, WidgetBuilder>{
        "/Home" : (context) => Home(),
        "/SignUp" : (context) => SignUp(),
        "/SignIn" : (context) => SignIn(),
      },
    );
  }
}

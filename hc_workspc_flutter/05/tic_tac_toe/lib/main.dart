import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home.dart';
import 'package:tic_tac_toe/toss.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool toss;

  void setToss(bool val) {
    setState(() {
      toss = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
      home: (toss == null) ? Toss(setToss: setToss,) : Home(toss: toss, setToss: setToss,),
      debugShowCheckedModeBanner: false,
    );
  }
}

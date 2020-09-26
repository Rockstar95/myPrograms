import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BG Changer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Random Backgroung'),),
        body: HomePage(
          
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var colors = [
    Colors.amber, Colors.black, Colors.blue, Colors.green,Colors.red,Colors.pink, Colors.orange, Colors.yellow,
  ];
  var currentColor = Colors.white;

  setRandomColor() {
    var randm = Random().nextInt(7);
    setState(() {
      currentColor = colors[randm];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentColor,
      child: Center(
        child: RaisedButton(
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
          child: Text(
            'Change Color',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
          onPressed: setRandomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

}

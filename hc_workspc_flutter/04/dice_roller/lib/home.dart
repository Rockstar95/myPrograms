import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AssetImage one = AssetImage('images/one.png');
  AssetImage two = AssetImage('images/two.png');
  AssetImage three = AssetImage('images/three.png');
  AssetImage four = AssetImage('images/four.png');
  AssetImage five = AssetImage('images/five.png');
  AssetImage six = AssetImage('images/six.png');

  AssetImage diceImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      diceImage = one;
    });
  }

  roll_Dice() {
    int randm = (1 + Random().nextInt(6));

    AssetImage newImage;

    switch(randm) {
      case 1 : newImage = one;break;
      case 2 : newImage = two;break;
      case 3 : newImage = three;break;
      case 4 : newImage = four;break;
      case 5 : newImage = five;break;
      case 6 : newImage = six;break;
    }

    setState(() {
      diceImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: diceImage,
                width: 200.0,
                height: 200.0,
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: RaisedButton(
                  onPressed: roll_Dice,
                  color: Colors.yellow,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  child: Text('Roll'),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

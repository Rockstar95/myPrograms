import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //TODO: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  //TODO: get an array
  List<String> itemArray;
  int luckyNumber, maxCounter, counter;
  bool isClickable;
  String msg;

  //TODO: init array with 25 elements
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generate_Random_Lucky_Number();
    counter = 0;
    maxCounter = 5;
    isClickable = true;
    msg = '';
  }

  void generate_Random_Lucky_Number() {
    int randm = Random().nextInt(25);

    setState(() {
      luckyNumber = randm;
    });
  }

  //TODO: define a getImage method
  AssetImage getImage(int  index) {
    String currentState = itemArray[index];

    switch(currentState) {
      case 'lucky' : return lucky;break;
      case 'unlucky' : return unlucky;break;
    }

    return circle;
  }

  //TODO: play game method
  playGame(int index) {
    if(isClickable) {
      if(luckyNumber == index) {
        setState(() {
          itemArray[index] = 'lucky';
        });
      }
      else {
        setState(() {
          itemArray[index] = 'unlucky';
        });
      }

      if(itemArray[index] == 'lucky') {
        setState(() {
          msg = "Cogratulations!!!!!  You've made it.";
          isClickable = false;
        });
        //return;
      }

      counter++;
      print('Counter:'+counter.toString());
      if(counter == maxCounter) {
        setState(() {
          isClickable = false;
          counter = 0;
          msg = "You've lost it";
          itemArray[luckyNumber] = "lucky";
        });
      }
    }
  }

  //TODO: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
      isClickable = false;
    });
  }

  //TODO: Reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, 'empty');
      counter = 0;
      msg = '';
      isClickable = true;
    });
    generate_Random_Lucky_Number();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch And Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      this.playGame(index);
                    },
                    child: Image(
                      image: this.getImage(index),
                    ),
                  ),
                );
              }
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Show All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Reset',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            color: Colors.black,
            child: Text('Learn Code Online', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }


}

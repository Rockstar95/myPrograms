import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toss extends StatefulWidget {

  final Function setToss;

  Toss({this.setToss});

  @override
  _TossState createState() => _TossState();
}

class _TossState extends State<Toss> {

  //TODO: Link Up Images
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');
  AssetImage circle = AssetImage('images/circle.png');

  //TODO: Get Image Method
  AssetImage getImage(String value) {
    switch(value) {
      case "empty" : return edit;break;
      case "cross" : return cross;break;
      case "circle" : return circle;break;
    }
  }

  //TODO: Create Method For Local Toss
  void toss() {
    setState(() {
      localToss = Random().nextBool();

      if(localToss) {
        currentImage = 'cross';
      }
      else {
        currentImage = 'circle';
      }

      msg = currentImage+' Won the Toss';
    });
  }

  String currentImage='empty';
  bool localToss;
  String msg='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toss'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                if(localToss == null) {
                  toss();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Image(
                image: this.getImage(this.currentImage),

              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () {
                if(localToss != null) {
                  widget.setToss(localToss);
                }
              },
              child: Text('Next', style: TextStyle(color: Colors.white),),
              color: Colors.purple[400],
            ),
            SizedBox(height: 20.0,),
            Text(msg),
          ],
        ),
      ),
    );
  }
}

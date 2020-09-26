import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  final bool toss;
  final Function setToss;

  Home({this.toss, this.setToss});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  //TODO: Link Up Images
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');
  AssetImage circle = AssetImage('images/circle.png');

  bool isCross= true;
  String message;
  List<String> gameState;

  //TODO: Initialize The State Of The Box With Empty
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.gameState = [
        "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty","empty",
      ];
      this.message = "";
      isCross = widget.toss;
    });
  }

  //TODO: Play Game Method
  playGame(int index) {
    if(message.isEmpty && this.gameState[index] == "empty") {
      setState(() {
        if(this.isCross) {
          this.gameState[index] = "cross";
        }
        else {
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  //TODO: Reset Game Method
  resetGame() {
    setState(() {
      gameState = [
        "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty","empty",
      ];

      this.message = "";

      widget.setToss(null);
    });
  }

  //TODO: Get Image Method
  AssetImage getImage(String value) {

    switch(value) {
      case "empty" : return edit;break;
      case "cross" : return cross;break;
      case "circle" : return circle;break;
    }
  }

  //TODO: Check For Win Logic
  checkWin() {
    if(gameState[0] != 'empty' && gameState[0] == gameState[1] && gameState[1] == gameState[2]) {
      setState(() {
        this.message = gameState[0] + 'Wins';
      });
    }
    else if(gameState[3] != 'empty' && gameState[3] == gameState[4] && gameState[4] == gameState[5]) {
      setState(() {
        this.message = gameState[3] + 'Wins';
      });
    }
    else if(gameState[6] != 'empty' && gameState[6] == gameState[7] && gameState[7] == gameState[8]) {
      setState(() {
        this.message = gameState[6] + 'Wins';
      });
    }
    else if(gameState[0] != 'empty' && gameState[0] == gameState[3] && gameState[3] == gameState[6]) {
      setState(() {
        this.message = gameState[0] + 'Wins';
      });
    }
    else if(gameState[1] != 'empty' && gameState[1] == gameState[4] && gameState[4] == gameState[7]) {
      setState(() {
        this.message = gameState[1] + 'Wins';
      });
    }
    else if(gameState[2] != 'empty' && gameState[2] == gameState[5] && gameState[5] == gameState[8]) {
      setState(() {
        this.message = gameState[2] + 'Wins';
      });
    }
    else if(gameState[0] != 'empty' && gameState[0] == gameState[4] && gameState[4] == gameState[8]) {
      setState(() {
        this.message = gameState[0] + 'Wins';
      });
    }
    else if(gameState[2] != 'empty' && gameState[2] == gameState[4] && gameState[4] == gameState[6]) {
      setState(() {
        this.message = gameState[2] + 'Wins';
      });
    }
    else if(!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: MaterialButton(
                    onPressed: () {
                      this.playGame(index);
                    },
                    child: Image(
                      image: this.getImage(this.gameState[index]),
                    ),
                ),);
              },
              padding: EdgeInsets.all(20.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              this.resetGame();
            },
            child: Text(
              'Reset Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              ),
            ),
            color: Colors.purple,
            minWidth: 300.0,
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('', style: TextStyle(fontSize: 12.0),),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Developed By Dishant Agrawal', style: TextStyle(fontSize: 12.0),),
          ),
        ],
      ),
    );
  }
}

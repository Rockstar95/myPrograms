import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.orange,
      accentColor: Colors.green,
    ),
    home: MyButton(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {

  int counter=0;
  List<String> spanishNmbers=['uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'seite', 'ocho', 'nueve', 'dietz'];
  String  defaultText='Spanish Number';

  void displayNumbers() {
    setState(() {
      if(counter == 10) {
        counter=0;
      }
      defaultText = spanishNmbers[counter];
      counter++;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stateful App'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(defaultText, style: TextStyle(fontSize: 30.0,),),
              SizedBox(height: 10.0,),
              RaisedButton(
                onPressed: displayNumbers,
                child: Text('Call Numbers'),
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

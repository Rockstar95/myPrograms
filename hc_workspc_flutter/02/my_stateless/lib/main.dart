import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Second'),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello world1'),
                Text('Hello world2'),
                Text('Hello world3'),
                RaisedButton(
                  onPressed: () {

                  },
                  child: Text('Login'),
                  color: Colors.orange,
                  splashColor: Colors.green,//Ripple Color
                ),
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Icon(Icons.add_a_photo, color: Colors.white,),
          backgroundColor: Colors.black,

        ),
      ),
    );
  }
}

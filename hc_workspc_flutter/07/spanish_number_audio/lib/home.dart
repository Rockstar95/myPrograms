import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spanish_number_audio/numberAudio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioCache _audioPlayer;
  List<NumberAudio> _audio_list;

  initialize() {
    _audioPlayer = AudioCache();
    _audio_list = [
      NumberAudio(audioUri: "one.wav", buttonColor: Colors.red, buttonText: "One"),
      NumberAudio(audioUri: "two.wav", buttonColor: Colors.green, buttonText: "Two"),
      NumberAudio(audioUri: "three.wav", buttonColor: Colors.blue, buttonText: "Three"),
      NumberAudio(audioUri: "four.wav", buttonColor: Colors.pink, buttonText: "Four"),
      NumberAudio(audioUri: "five.wav", buttonColor: Colors.brown, buttonText: "Five"),
      NumberAudio(audioUri: "six.wav", buttonColor: Colors.blueGrey, buttonText: "Six"),
      NumberAudio(audioUri: "seven.wav", buttonColor: Colors.teal, buttonText: "Seven"),
      NumberAudio(audioUri: "eight.wav", buttonColor: Colors.grey, buttonText: "Eight"),
      NumberAudio(audioUri: "nine.wav", buttonColor: Colors.orange, buttonText: "Nine"),
      NumberAudio(audioUri: "ten.wav", buttonColor: Colors.purple, buttonText: "Ten"),
    ];
  }

  play(String uri) {
    _audioPlayer.play(uri);
  }

  @override
  Widget build(BuildContext context) {
    initialize();

    return Scaffold(
      appBar: AppBar(
        title: Text('Spanish Number Audio'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage("images/logo.png"),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _audio_list.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          play(_audio_list[index].audioUri);
                        },
                        color: _audio_list[index].buttonColor,
                        child: Text(
                          _audio_list[index].buttonText,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

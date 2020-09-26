import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  final String title;

  Home( {Key key, @required this.title } ):super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final String url="https://api.github.com/users";
  List data;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }

  void getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    data[index]["login"].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  subtitle: Text(
                    data[index]["url"].toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}

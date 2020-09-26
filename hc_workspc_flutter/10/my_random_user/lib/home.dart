import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List userData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=50";

  Future getData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "application/json"});

    setState(() {
      userData = json.decode(response.body)["results"];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ?
          CircularProgressIndicator() :

          ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Image(
                        image: NetworkImage(userData[index]["picture"]["thumbnail"]),
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                              userData[index]["name"]["first"]+ "  " + userData[index]["name"]["last"],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 17.0,),
                              Text("  " + userData[index]["phone"]),
                            ],
                          ),
                          Text("Gender: "+userData[index]["gender"]),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },

          )
        ),
      ),
    );
  }
}

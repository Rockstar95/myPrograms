import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaselogin/screens/add_contact.dart';
import 'package:firebaselogin/screens/edit_contact.dart';
import 'package:firebaselogin/screens/view_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  void navigateToAddContact() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Add_Contact();
    }));
  }

  void navigateToEditContact() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Edit_Contact();
    }));
  }

  dynamic navigateToViewContact(String id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return View_Contact(id: id,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact App"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            return GestureDetector(
              onTap: () {
                navigateToViewContact(snapshot.key);
              },
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: snapshot.value["photoUrl"] == "empty"
                              ? DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(snapshot.value["photoUrl"]),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.value["firstname"]} ${snapshot.value["lastname"]}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${snapshot.value["phone"]}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: navigateToAddContact,
      ),
    );
  }
}

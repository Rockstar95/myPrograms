import 'package:firebase_database/firebase_database.dart';
import 'package:firebaselogin/model/contact.dart';
import 'package:firebaselogin/screens/edit_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class View_Contact extends StatefulWidget {

  String id;

  View_Contact( {this.id});

  @override
  _View_ContactState createState() => _View_ContactState(id: id);
}

class _View_ContactState extends State<View_Contact> {

  String id;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  Contact _contact;
  bool _isLoading = true;

  _View_ContactState( { this.id });

  getContact(String id) async {
    await _databaseReference.child(id).onValue.listen((event) {
      setState(() {
        _contact = Contact.fromSnapshot(event.snapshot);
        this._isLoading = false;
      });
    });
  }

  callAction(String number) async {
    String url = "tel:$number";
    if(await canLaunch(url)) {
       await launch(url);
    }
    else {
      throw "Could Not Call $number";
    }
  }

  smsAction(String number) async {
    String url = "sms:$number";
    if(await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw "Could Not send sms to $number";
    }
  }

  dynamic navigateToLastScreen() {
    Navigator.of(this.context).pop();
  }

  dynamic navigateToEditScreen(String id) {
    Navigator.of(this.context).push(MaterialPageRoute(builder: (context) {
      return Edit_Contact(id: id,);
    }));
  }

  dynamic deleteContact() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Delete Contact?"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async {
                await _databaseReference.child(id).remove();
                navigateToLastScreen();
                navigateToLastScreen();
              },
              child: Text("Delete"),
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getContact(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
      ),
      body: Container(
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView(
          children: <Widget>[
            // header text container
            Container(
                height: 200.0,
                child: Image(
                  //
                  image: _contact.photoUrl == "empty"
                      ? AssetImage("assets/logo.png")
                      : NetworkImage(_contact.photoUrl),
                  fit: BoxFit.contain,
                )),
            //name
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.perm_identity),
                      Container(
                        width: 10.0,
                      ),
                      Text(
                        "${_contact.firstName} ${_contact.lastName}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ),
            // phone
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.phone),
                      Container(
                        width: 10.0,
                      ),
                      Text(
                        _contact.phone,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ),
            // email
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      Container(
                        width: 10.0,
                      ),
                      Text(
                        _contact.email,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ),
            // address
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home),
                      Container(
                        width: 10.0,
                      ),
                      Text(
                        _contact.address,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ),
            // call and sms
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.phone),
                        color: Colors.red,
                        onPressed: () {
                          callAction(_contact.phone);
                        },
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.message),
                        color: Colors.red,
                        onPressed: () {
                          smsAction(_contact.phone);
                        },
                      )
                    ],
                  )),
            ),
            // edit and delete
            Card(
              elevation: 2.0,
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.edit),
                        color: Colors.red,
                        onPressed: () {
                          navigateToEditScreen(id);
                        },
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          deleteContact();
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

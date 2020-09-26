import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaselogin/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Add_Contact extends StatefulWidget {
  @override
  _Add_ContactState createState() => _Add_ContactState();
}

class _Add_ContactState extends State<Add_Contact> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _id = "", _firstName = "", _lastName = "", _phone = "", _email = "", _address = "", _photoUrl = "empty";

  Future<void> saveContact(BuildContext context) async {
    if(_firstName.isNotEmpty && _lastName.isNotEmpty && _phone.isNotEmpty && _email.isNotEmpty && _address.isNotEmpty) {
      Contact contact = Contact(_firstName.trim(), _lastName.trim(), _phone.trim(), _email.trim(), _address.trimLeft().trimRight(), _photoUrl);

      await _databaseReference.push().set(contact.toJson());
      navigateToLastScreen();
    }
    else {
      showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            title: Text("Field Required"),
            content: Text("All fields are required"),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: Navigator.of(context).pop,
              ),
            ],
          );
        }
      );
    }
  }

  Future pickImage() async {
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery, maxHeight: 200.0, maxWidth: 200.0, );
    if(file != null) {
      //print("Not Null");
      String fileName = basename(file.path);
      uploadImage(File(file.path), fileName);
    }/*
    else {
      print("null");
    }*/
  }

  void uploadImage(File file, String fileName) {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();
      setState(() {
        _photoUrl = downloadUrl;
      });
    });
  }

  void navigateToLastScreen()   {
    Navigator.of(this.context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: pickImage,
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _photoUrl == "empty" ? AssetImage("assets/logo.png") : NetworkImage(_photoUrl)
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _firstName = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _lastName = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _address = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _phone = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () {
                  saveContact(context);
                },
                child: Text(
                    "Add Contact",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

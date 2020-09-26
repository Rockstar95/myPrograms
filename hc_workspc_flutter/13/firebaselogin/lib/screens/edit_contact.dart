import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaselogin/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Edit_Contact extends StatefulWidget {
  String id;

  Edit_Contact({this.id});

  @override
  _Edit_ContactState createState() => _Edit_ContactState(id: id);
}

class _Edit_ContactState extends State<Edit_Contact> {
  String id;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  bool _isLoading = true;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String _photoUrl = "empty";

  //Constructor
  _Edit_ContactState({this.id});

  dynamic getContact(String id) async {
    await _databaseReference.child(id).onValue.listen((event) {
      Contact _contact = Contact.fromSnapshot(event.snapshot);

      setState(() {
        _firstnameController.text = _contact.firstName;
        _lastnameController.text = _contact.lastName;
        _emailController.text = _contact.email;
        _phoneController.text = _contact.phone;
        _addressController.text = _contact.address;
        _photoUrl = _contact.photoUrl;

        _isLoading = false;
        print("IsLoading:" + _isLoading.toString());
      });
    });
  }

  Future pickImage() async {
    PickedFile file = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0,
    );
    if (file != null) {
      //print("Not Null");
      String fileName = basename(file.path);
      uploadImage(File(file.path), fileName);
    }
    /*
    else {
      print("null");
    }*/
  }

  void uploadImage(File file, String fileName) {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);

    storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();
      setState(() {
        _photoUrl = downloadUrl;
      });
    });
  }

  dynamic updateContact() async {
    if (_firstnameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      Contact c = Contact.withId(
          this.id,
          this._firstnameController.text,
          this._lastnameController.text,
          this._phoneController.text,
          this._emailController.text,
          this._addressController.text,
          this._photoUrl);

      await _databaseReference.child(id).set(c.toJson());
      navigateToLastScreen();
    } else {
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
          });
    }
  }

  dynamic navigateToLastScreen() {
    Navigator.of(this.context).pop();
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
        title: Text("Edit Contact"),
      ),
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    //image view
                    Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            this.pickImage();
                          },
                          child: Center(
                            child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _photoUrl == "empty"
                                          ? AssetImage("assets/logo.png")
                                          : NetworkImage(_photoUrl),
                                    ))),
                          ),
                        )),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: _firstnameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    // update button
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                        onPressed: () {
                          updateContact();
                        },
                        color: Colors.red,
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

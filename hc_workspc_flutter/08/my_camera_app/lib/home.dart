import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _image;

  Future _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future _openGallary() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> _optionDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text(
                    'Take A Picture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: _openCamera,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                GestureDetector(
                  child: Text(
                    'Select From Gallary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: _openGallary,
                ),
              ],
            ),
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Camera App'),
      ),
      body: Center(
        child: _image == null ? Text('No Image') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optionDialogBox,
        child: Icon(Icons.add_a_photo),
        tooltip: "Open Camera",
      ),
    );
  }
}

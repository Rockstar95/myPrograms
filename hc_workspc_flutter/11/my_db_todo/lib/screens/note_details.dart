import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_db_todo/database_helper.dart';
import 'package:my_db_todo/note.dart';

class Note_Details extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  Note_Details({this.note, this.appBarTitle});

  @override
  _Note_DetailsState createState() => _Note_DetailsState(appBarTitle: appBarTitle, note: note);
}

class _Note_DetailsState extends State<Note_Details> {

  static var _priorities = ['High', 'Low'];
  String appBarTitle;
  Note note;
  Database_Helper _database_helper;

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _descriptionEditingController = TextEditingController();

  _Note_DetailsState({this.note, this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    _titleEditingController.text = note.title;
    _descriptionEditingController.text = note.description;
    _database_helper = Database_Helper();

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: moveToLastScreen,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  //dropdown menu
                  child: new ListTile(
                    leading: const Icon(Icons.low_priority),
                    title: DropdownButton(
                        items: _priorities.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          );
                        }).toList(),
                        value: getPriorityAsString(note.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                ),
                // Second Element
                Padding(
                  padding:
                  EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: _titleEditingController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      icon: Icon(Icons.title),
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding:
                  EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: _descriptionEditingController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      icon: Icon(Icons.details),
                    ),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.red,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = _titleEditingController.text;
  }

  void updateDescription() {
    note.description = _descriptionEditingController.text;
  }

  void _save() async {
    await moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if(note.id != null) {
      result = await _database_helper.updateNote(note);
    }
    else {
      result = await _database_helper.insertNote(note);
    }

    if(result != 0) {
      _showAlertDialog("Staus", "Note Saved Successfully");
    }
    else {
      _showAlertDialog("Staus", "Problem In Saving Note");
    }

  }

  void _delete() async  {
    moveToLastScreen();

    if(note.id == null) {
      _showAlertDialog("Staus", "First Add A Note");
      return;
    }

    int result = await _database_helper.deleteNote(note.id);
    if(result != 0) {
      _showAlertDialog("Staus", "Note Deleted Successfully");
    }
    else {
      _showAlertDialog("Staus", "Problem In Deleting Note");
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog _alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => _alertDialog);
  }

  //Convert priority Into int to save into database
  void updatePriorityAsInt(String value) {
    switch(value) {
      case 'High' : note.priority = 1;break;
      case 'Low' : note.priority = 2;break;
    }
  }

  //Convert priority Into String to save into database
  String getPriorityAsString(int value) {
    String priority;

    switch(value) {
      case 1 : priority = _priorities[0];break;
      case 2 : priority = _priorities[1];break;
    }

    return priority;
  }
}

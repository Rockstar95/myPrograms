import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_db_todo/database_helper.dart';
import 'package:my_db_todo/screens/note_details.dart';
import 'package:sqflite/sqflite.dart';

import '../note.dart';

class Note_List extends StatefulWidget {
  @override
  _Note_ListState createState() => _Note_ListState();
}

class _Note_ListState extends State<Note_List> {

  Database_Helper _database_helper = Database_Helper();
  List<Note> _noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(_noteList == null) {
      _noteList = List<Note>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('LCO TODO'),
        backgroundColor: Colors.purple,
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetails(Note('', '', 2), "Add Note");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Future<Note_Details> navigateToDetails(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Note_Details(note: note,appBarTitle: title,);
        },
    ));

    if(result == true) {
      updateListView();
    }
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://learncodeonline.in/mascot.png"),
            ),
            title: Text(
              this._noteList[index].title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              this._noteList[index].date,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: GestureDetector(
              child: Icon(Icons.open_in_new, color: Colors.white,),
              onTap: () {
                navigateToDetails(this._noteList[index], "Edit Todo");
              },
            ),
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = _database_helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = _database_helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this._noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

}

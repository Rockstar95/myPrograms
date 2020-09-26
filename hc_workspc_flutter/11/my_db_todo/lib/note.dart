import 'dart:core';

class Note {

  int _id;
  String _title, _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);
  Note.withid(this._id, this._title, this._date, this._priority, [this._description]);


  //Getters and Setters--------------------------------------------------------------------
   int get priority => _priority;

  set priority(int value) {

    if(value>=1 && value<=2) {
      this._priority=value;
    }
  }

  String get date => _date;

  set date(String value) {
    this._date = value;
  }

  get description => _description;

  set description(value) {
    this._description = value;
  }

  String get title => _title;

  set title(String value) {
    this._title = value;
  }

  int get id => _id;

  set id(int value) {
    this._id = value;
  }

  //-------------------------------------------------------------------------------------------

//Used To Save And Retrieve From Database------------------------------------------------------

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if(_id!=null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

   Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}
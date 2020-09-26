import 'package:firebase_database/firebase_database.dart';

class Contact {

  //Variables
  String _id, _firstName, _lastName, _phone, _email, _address, _photoUrl;

  //Constructors
  Contact(this._firstName, this._lastName, this._phone, this._email, this._address, this._photoUrl);
  Contact.withId(this._id, this._firstName, this._lastName, this._phone, this._email, this._address, this._photoUrl);

  //Getters And Setters----------------------------------------------------------------------------------
  get photoUrl => _photoUrl;

  set photoUrl(value) {
    _photoUrl = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  get lastName => _lastName;

  set lastName(value) {
    _lastName = value;
  }

  get firstName => _firstName;

  set firstName(value) {
    _firstName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
  //----------------------------------------------------------------------------------------------------

  Contact.fromSnapshot(DataSnapshot snapshot) {
    this._id = snapshot.key;
    this._firstName = snapshot.value['firstname'];
    this._lastName = snapshot.value['lastname'];
    this._phone = snapshot.value['phone'];
    this._email = snapshot.value['email'];
    this._address = snapshot.value['address'];
    this._photoUrl = snapshot.value['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname" : _firstName,
      "lastname" : _lastName,
      "phone" : _phone,
      "email" : _email,
      "address" : _address,
      "photoUrl" : _photoUrl,
    };
  }

}
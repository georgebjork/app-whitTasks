import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class User{
  int user_id;
  String first_name = "";
  String last_name = "";
  String date;
  String email = "";
  String password = "";

  User(this.first_name, this.last_name, this.user_id, this.date, this.email, this.password);

  User.fromUser({
    @required this.user_id,
    @required this.first_name,
    @required this.last_name,
    @required this.date,
    @required this.email,
    @required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json)
  {
    return User.fromUser(
      user_id: json['user_id'] as int, 
      first_name: json['first_name'] as String, 
      last_name: json['last_name'] as String, 
      date: json['date'] as String, 
      email: json['email'] as String, 
      password: json['password'] as String
    );
  }

}
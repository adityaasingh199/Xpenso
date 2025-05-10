import 'package:xpenso/data/db_helper/db_helper.dart';

class userModel {
  int? uid;
  String name;
  String email;
  String password;
  String monNo;
  String createdAt;

  userModel(
      {this.uid,
      required this.name,
      required this.email,
      required this.monNo,
      required this.password,
      required this.createdAt});

  factory userModel.fromMap(Map<String, dynamic> map) {
    return userModel(
        uid: map[dbHelper.USER_ID],
        name: map[dbHelper.USER_NAME],
        email: map[dbHelper.USER_EMAIL],
        monNo: map[dbHelper.USER_MOBILE],
        password: map[dbHelper.USER_PASSWORD],
        createdAt: map[dbHelper.USER_CREATED_AT]);
  }

  Map<String, dynamic> toMap() {
    return {
      dbHelper.USER_NAME: name,
      dbHelper.USER_EMAIL: email,
      dbHelper.USER_MOBILE: monNo,
      dbHelper.USER_PASSWORD: password,
      dbHelper.USER_CREATED_AT: createdAt,
    };
  }
}

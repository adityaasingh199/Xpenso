import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpenso/data/model/expense_model.dart';
import 'package:xpenso/data/model/model.dart';
import 'package:xpenso/domain/app_constants.dart';

class dbHelper {
  dbHelper._();
  static dbHelper getInstance() => dbHelper._();

  static const String USER_TABLE = "user_table";
  static const String USER_ID = "user_id";
  static const String USER_NAME = "user_name";
  static const String USER_EMAIL = "user_email";
  static const String USER_PASSWORD = "user_password";
  static const String USER_MOBILE = "user_mobile";
  static const String USER_CREATED_AT = "created_at";

  static const String EXPENSE_TABLE = "expense_table";
  static const String EXPENSE_ID = "expense_id";
  static const String EXPENSE_TITLE = "expense_title";
  static const String EXPENSE_DESCRIPTION = "expense_description";
  //static const String EXPENSE_DATE = "expense_date";
  static const String EXPENSE_AMOUNT = "expense_amount";
  static const String EXPENSE_BALANCE = "expense_balance";
  static const String EXPENSE_TYPE = "expense_type";
  static const String EXPENSE_CATEGORY = "expense_category_id";
  static const String EXPENSE_CREATED_AT = "expense_created_at";

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await openDb();
    return _db!;
  }

  Future<Database> openDb() async {
    Directory appDoc = await getApplicationCacheDirectory();
    String dbPath = join(appDoc.path, "expenseDb.db");

    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          "create table $USER_TABLE($USER_ID integer primary key autoincrement, $USER_NAME text not null, $USER_EMAIL text not null, $USER_PASSWORD text not null, $USER_MOBILE text, $USER_CREATED_AT text not null)");
      await db.execute(
          "create table $EXPENSE_TABLE($EXPENSE_ID integer primary key autoincrement, $USER_ID integer, $EXPENSE_TITLE text not null, $EXPENSE_DESCRIPTION text, $EXPENSE_AMOUNT real not null, $EXPENSE_BALANCE real, $EXPENSE_TYPE text, $EXPENSE_CATEGORY integer, $EXPENSE_CREATED_AT text)");
    });
  }

  Future<bool> registerUser(userModel newModel) async {
    var db = await getDB();
    int rowEffected = await db.insert(USER_TABLE, newModel.toMap());
    return rowEffected > 0;
  }

  Future<bool> isEmailAlreadyExists({required String email}) async {
    var db = await getDB();
    List<Map<String, dynamic>> mData =
        await db.query(USER_TABLE, where: "$USER_EMAIL=?", whereArgs: [email]);
    return mData.isNotEmpty;
  }

  Future<bool> authenticateUser(
      {String mobNo = "",
      String email = "",
      required String pass,
      bool isEmail = true}) async {
    var db = await getDB();
    var mData = isEmail
        ? await db.query(USER_TABLE,
            where: "$USER_EMAIL=? and $USER_PASSWORD =?",
            whereArgs: [email, pass])
        : await db.query(USER_TABLE,
            where: "$USER_MOBILE=? and $USER_PASSWORD =?",
            whereArgs: [mobNo, pass]);

    if (mData.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(AppConstants.USER_ID, userModel.fromMap(mData[0]).uid ?? 0);
    }
    return mData.isNotEmpty;
  }

  Future<bool> addExpense({required expenseModel newExp}) async{
    var db = await getDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.USER_ID) ?? 0;

    newExp.uid = uid;

    int rowsEffected = await db.insert( EXPENSE_TABLE, newExp.toMap());
    return rowsEffected>0;
  }

  Future<List<expenseModel>> fetchAllExpense()async{
    var db = await getDB();
    List<Map<String,dynamic>> mExp = await db.query(EXPENSE_TABLE);

    List<expenseModel> allExp = [];

    for( Map<String,dynamic> eachExp in mExp){
      allExp.add(expenseModel.fromMap(eachExp));
    }
    return allExp;
  }
}

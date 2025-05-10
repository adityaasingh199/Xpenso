import 'package:xpenso/data/db_helper/db_helper.dart';

class expenseModel {
  int? eid;
  int? uid;
  int catId;
  num amt;
  num bal;
  String title;
  String desc;
  String type;
  String createdAt;

  expenseModel(
      {this.eid,
      this.uid,
      required this.title,
      required this.desc,
      required this.amt,
      required this.bal,
      required this.catId,
      required this.createdAt,
      required this.type});

  factory expenseModel.fromMap(Map<String, dynamic> map) {
    return expenseModel(
        eid: map[dbHelper.EXPENSE_ID],
        uid: map[dbHelper.USER_ID],
        title: map[dbHelper.EXPENSE_TITLE],
        amt: map[dbHelper.EXPENSE_AMOUNT],
        bal: map[dbHelper.EXPENSE_BALANCE],
        catId: map[dbHelper.EXPENSE_CATEGORY],
        desc: map[dbHelper.EXPENSE_DESCRIPTION],
        createdAt: map[dbHelper.EXPENSE_CREATED_AT],
        type: map[dbHelper.EXPENSE_TYPE]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      dbHelper.USER_ID:uid,
      dbHelper.EXPENSE_ID:eid,
      dbHelper.EXPENSE_TITLE:title,
      dbHelper.EXPENSE_DESCRIPTION:desc,
      dbHelper.EXPENSE_CREATED_AT:createdAt,
      dbHelper.EXPENSE_CATEGORY:catId,
      dbHelper.EXPENSE_AMOUNT:amt,
      dbHelper.EXPENSE_BALANCE:bal,
      dbHelper.EXPENSE_TYPE:type
    };
  }

}

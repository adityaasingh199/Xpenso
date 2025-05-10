import 'package:xpenso/data/model/expense_model.dart';

class filterExpenseModel{
  String type;
  num totalAmt;
  List<expenseModel> mExpenses;

  filterExpenseModel({required this.type,required this.totalAmt,required this.mExpenses});
}
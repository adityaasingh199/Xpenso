import 'package:xpenso/data/model/expense_model.dart';

abstract class expenseEvent{}

class addExpenseEvent extends expenseEvent{

  expenseModel newExp;
  addExpenseEvent({required this.newExp});
}

class getInitialExpEvent extends expenseEvent{
  int type;
  getInitialExpEvent({this.type =1});
}
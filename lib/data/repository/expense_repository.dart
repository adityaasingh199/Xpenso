import 'package:xpenso/data/db_helper/db_helper.dart';
import 'package:xpenso/data/model/filter_expense_model.dart';
import 'package:xpenso/domain/app_constants.dart';

import '../model/expense_model.dart';

class expenseRepository{
  dbHelper DbHelper;
  expenseRepository({required this.DbHelper});

 Future<bool>AddExpense({required expenseModel newRepoExp })async{
  return await DbHelper.addExpense(newExp: newRepoExp);
 }

 /*Future<List<filterExpenseModel>>InitialFilterExpense()async{
   List<expenseModel>allExp = await DbHelper.fetchAllExpense();
   List<filterExpenseModel> allFilterExp = AppConstants.filterExpenseType(allExpense: allExp,type: 1);
   return allFilterExp;
 }*/
 Future<List<filterExpenseModel>> FilterExpense({int type=1 })async{
   List<expenseModel> allExp = await DbHelper.fetchAllExpense();
   List<filterExpenseModel> allFilterExp = AppConstants.filterExpenseType(allExpense: allExp,type: type);
   return allFilterExp;
 }

}
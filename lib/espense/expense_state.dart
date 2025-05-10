import 'package:xpenso/data/model/filter_expense_model.dart';

abstract class expenseState{}

class expenseInitalState extends expenseState{}
class expenseLoadingState extends expenseState{}
class expenseLoadedState extends expenseState{
  List<filterExpenseModel> allExpenses;
  expenseLoadedState({required this.allExpenses});
}
class expenseErrorState extends expenseState{
  String errorMsg;
  expenseErrorState({required this.errorMsg});
}
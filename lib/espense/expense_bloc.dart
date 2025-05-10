import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpenso/data/db_helper/db_helper.dart';
import 'package:xpenso/data/model/expense_model.dart';
import 'package:xpenso/data/model/filter_expense_model.dart';
import 'package:xpenso/data/repository/expense_repository.dart';
import 'package:xpenso/domain/app_constants.dart';
import 'package:xpenso/espense/expense_event.dart';
import 'package:xpenso/espense/expense_state.dart';

class expenseBloc extends Bloc<expenseEvent,expenseState>{
  
  expenseRepository ExpenseRepository;
  expenseBloc({required this.ExpenseRepository}) : super(expenseInitalState()){

    on<addExpenseEvent>((event, emit)async{
      emit(expenseLoadingState());
      if(await ExpenseRepository.AddExpense(newRepoExp: event.newExp)){
        emit(expenseLoadedState(allExpenses: await ExpenseRepository.FilterExpense()));
      }else{
        emit(expenseErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<getInitialExpEvent>((event, emit)async{
      emit(expenseLoadingState());

      emit(expenseLoadedState(allExpenses: await ExpenseRepository.FilterExpense(type: event.type)));
    });

  }

  
}



/*
class expenseBloc extends Bloc<expenseEvent,expenseState>{

  dbHelper DbHelper;
  expenseBloc({required this.DbHelper}) : super(expenseInitalState()){

    on<addExpenseEvent>((event, emit)async{
      emit(expenseLoadingState());
      bool check = await DbHelper.addExpense(newExp: event.newExp);

      if(check){
        List<expenseModel> allExp = await DbHelper.fetchAllExpense();

        ///Initial Filter type
        List<filterExpenseModel> allFilterExp = AppConstants.filterExpenseType(allExpense: allExp,type: 1);
        emit(expenseLoadedState(allExpenses: allFilterExp));
      }else{
        emit(expenseErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<getInitialExpEvent>((event, emit)async{
      emit(expenseLoadingState());
      List<expenseModel> allExp = await DbHelper.fetchAllExpense();

      ///Adding Filter here
      List<filterExpenseModel> allFilterExp = AppConstants.filterExpenseType(allExpense: allExp,type: event.type);
      emit(expenseLoadedState(allExpenses: allFilterExp));
    });

  }
}*/

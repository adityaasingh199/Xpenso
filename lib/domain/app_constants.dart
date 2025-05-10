import 'package:intl/intl.dart';
import 'package:xpenso/data/model/cat_model.dart';

import '../data/model/expense_model.dart';
import '../data/model/filter_expense_model.dart';

class AppConstants{

  static final String USER_ID = 'uid';


  static List<categoryModel> mCat = [
    categoryModel(id: 1, name: "Car", imgPath:"asset/image/cat_images/car.png"),
    categoryModel(id: 2, name: "Movies", imgPath:"asset/image/cat_images/cinema.png"),
    categoryModel(id: 3, name: "Electric", imgPath:"asset/image/cat_images/electrical.png"),
    categoryModel(id: 4, name: "Fuel", imgPath:"asset/image/cat_images/fuel.png"),
    categoryModel(id: 5, name: "Grocery", imgPath:"asset/image/cat_images/grocery.png"),
    categoryModel(id: 6, name: "SmartPhone", imgPath:"asset/image/cat_images/smartphone.png"),
    categoryModel(id: 7, name: "Snack", imgPath:"asset/image/cat_images/snack.png"),
    categoryModel(id: 8, name: "Travel", imgPath:"asset/image/cat_images/travel.png"),

  ];


  static filterExpenseType({required List<expenseModel> allExpense, int type = 1}){

    List<filterExpenseModel> allFilteredExpenses = [];

    DateFormat df = DateFormat.yMMMEd();

    allFilteredExpenses.clear();
    if(type<4){
      if(type ==1){
        df = DateFormat.yMMMEd();
      }else if(type ==2){
        df = DateFormat.yMMM();
      }else{
        df = DateFormat.y();
      }

      List<String> uniqueMonths =[];

      for(expenseModel eachExp in allExpense){
        String date = df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
        if(!uniqueMonths.contains(date)){
          uniqueMonths.add(date);
        }
      }
      for (String eachDate in uniqueMonths){
        num eachDateTotalAmt = 0.0;
        List<expenseModel>eachDateExpenses =[];
        for(expenseModel eachExp in allExpense){
          String date = df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
          if(eachDate == date){
            eachDateExpenses.add(eachExp);

            if(eachExp.type == "Debit"){
              eachDateTotalAmt -= eachExp.amt;
            }else{
              eachDateTotalAmt += eachExp.amt;
            }
          }
        }
        allFilteredExpenses.add(filterExpenseModel(type: eachDate, totalAmt: eachDateTotalAmt, mExpenses: eachDateExpenses));
      }
    }else{
      for(categoryModel eachCat in AppConstants.mCat){
        num eachCatTotalAmt = 0.0;
        List<expenseModel> eachCatExpenses = [];

        for(expenseModel eachExp in allExpense){
          if(eachCat.id == eachExp.catId){
            eachCatExpenses.add(eachExp);

            if(eachExp.type == "Debit"){
              eachCatTotalAmt -= eachExp.amt;
            }else{
              eachCatTotalAmt += eachExp.amt;
            }
          }
        }
        if(eachCatExpenses.isNotEmpty){
          allFilteredExpenses.add(filterExpenseModel(type: eachCat.name, totalAmt: eachCatTotalAmt, mExpenses: eachCatExpenses));
        }
      }

    }
    return allFilteredExpenses;

  }

}
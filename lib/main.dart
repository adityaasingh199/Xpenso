import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:xpenso/data/db_helper/db_helper.dart';
import 'package:xpenso/data/repository/expense_repository.dart';
import 'package:xpenso/data/repository/user_repository.dart';
import 'package:xpenso/espense/expense_bloc.dart';
import 'package:xpenso/log_in/log_in/login_bloc.dart';
import 'package:xpenso/log_in/sign_up/sign_up_bloc.dart';
import 'package:xpenso/splash/splash_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context)=>registerBloc(UserRepository: userRepository(Dbhelper: dbHelper.getInstance()))),
    BlocProvider(create: (context)=>loginBloc(UserRepository: userRepository(Dbhelper: dbHelper.getInstance()))),
    BlocProvider(create: (context)=>expenseBloc(ExpenseRepository: expenseRepository(DbHelper: dbHelper.getInstance())))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashPage()
    );
  }
}

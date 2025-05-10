import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpenso/data/repository/user_repository.dart';
import 'package:xpenso/log_in/log_in/login_event.dart';
import 'package:xpenso/log_in/log_in/login_state.dart';

class loginBloc extends Bloc<loginEvent,loginState>{

  userRepository UserRepository;
  loginBloc({required this.UserRepository}) : super(loginInitalState()){
    on<AuthenticateUserEvent>((event,emit)async{
      emit(loginLoadingState());
      bool check = await UserRepository.authenticateUser(pass: event.pass,email: event.email, mobNo: event.mobNo, isEmail: event.isEmail);

      if(check){
        emit(logininSuccessState());
      }else{
        emit(loginFailureState(errorMsg: "Invalid Credentials!!"));
      }

    });
  }


}
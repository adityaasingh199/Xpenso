import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpenso/data/repository/user_repository.dart';
import 'package:xpenso/log_in/sign_up/sign_up_event.dart';
import 'package:xpenso/log_in/sign_up/sign_up_state.dart';

class registerBloc extends Bloc<registerEvent,registerState>{
  userRepository UserRepository;
  registerBloc({required this.UserRepository}) : super(registerInitialState()){

    on<registerUserEvent>((event,emit)async{
      emit(registerLoadingState());

      if(await UserRepository.checkEmailAlreadyExists(email: event.newUser.email)){
        emit(registerFailureState(errorMsg: "Email is already exists"));
      }else{
        bool check = await UserRepository.registerUser(newUser: event.newUser);
        if(check){
          emit(registerSuccessState());
        }else{
          emit(registerFailureState(errorMsg: "Something went wrong"));
        }
      }
    });
  }
}
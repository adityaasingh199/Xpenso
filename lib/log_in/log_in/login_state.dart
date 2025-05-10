abstract class loginState{}

class loginInitalState extends loginState{}
class loginLoadingState extends loginState{}
class logininSuccessState extends loginState{}
class loginFailureState extends loginState{
  String errorMsg;
  loginFailureState({required this.errorMsg});
}
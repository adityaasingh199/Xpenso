abstract class registerState{}

class registerInitialState extends registerState{}
class registerLoadingState extends registerState{}
class registerSuccessState extends registerState{}
class registerFailureState extends registerState{
  String errorMsg;
  registerFailureState({required this.errorMsg});
}
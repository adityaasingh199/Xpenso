abstract class loginEvent{}

class AuthenticateUserEvent extends loginEvent{
  String? email;
  String? mobNo;
  String pass;
  bool isEmail;

  AuthenticateUserEvent({this.email, this.mobNo, required this.pass, this.isEmail=true });
}
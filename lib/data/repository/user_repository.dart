import 'package:xpenso/data/db_helper/db_helper.dart';
import 'package:xpenso/data/model/model.dart';

class userRepository {
  dbHelper Dbhelper;
  userRepository({required this.Dbhelper});

  Future<bool>registerUser({required userModel newUser})async{
    bool check = await Dbhelper.registerUser(newUser);
    return check;
  }

  Future<bool>checkEmailAlreadyExists({required String email})async{
    return await Dbhelper.isEmailAlreadyExists(email: email);
  }

  Future<bool>authenticateUser({String? email, String? mobNo,required String pass, bool isEmail = true})async{
    if(isEmail){
      return await Dbhelper.authenticateUser(email: email!, pass: pass,isEmail: isEmail);
    }else{
      return await Dbhelper.authenticateUser(mobNo: mobNo!, pass: pass,isEmail: isEmail);
    }
  }
}
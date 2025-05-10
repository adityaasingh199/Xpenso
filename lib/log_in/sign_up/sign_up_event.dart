import 'package:xpenso/data/model/model.dart';

abstract class registerEvent{}

class registerUserEvent extends registerEvent{
  userModel newUser;
  registerUserEvent({required this.newUser});
}
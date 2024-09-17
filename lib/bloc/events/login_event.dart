
abstract class LoginEvent{}

class LoginEventSubmit extends LoginEvent{
  String userName;
  String password;
  LoginEventSubmit({required this.userName, required this.password});
}

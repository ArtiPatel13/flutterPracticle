import '../../model/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState({required this.error});
}

class LoginNetworkErrorState extends LoginStates{
  final String error;
  LoginNetworkErrorState({required this.error});
}

class LoginResponseErrorState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  LoginModel? model;
  LoginSuccessState({this.model});
}

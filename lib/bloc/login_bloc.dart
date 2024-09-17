
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle/bloc/states/login_state.dart';
import '../../constant/strings.dart';
import '../repo/login_repo.dart';
import 'events/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginRepo appRepository;

  LoginBloc({required this.appRepository}) : super(LoginInitialState()) {
    on<LoginEventSubmit>(_CallLoginAPI);
  }

  void _CallLoginAPI(LoginEventSubmit event,
      Emitter<LoginStates> emit) async {

    try {
      emit(LoginLoadingState());
      final response = await appRepository.callLoginAPI(event);
      if (response.getException == null) {
        emit(LoginSuccessState(model: response.getData));
      }
      else {
        var error =
            await response.getException?.errorMessage ?? somethingWentWrong;
        if (error == noInternet) {
          emit(LoginNetworkErrorState(error: error));
        } else {
          emit(LoginErrorState(error: error));
        }
      }
    }
    on Exception catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }

}

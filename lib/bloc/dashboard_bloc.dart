
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle/bloc/states/dashboard_state.dart';
import 'package:flutter_practicle/repo/login_repo.dart';
import '../../constant/strings.dart';
import 'events/dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStates> {
  LoginRepo appRepository;

  DashboardBloc({required this.appRepository}) : super(DashboardInitialState()) {
    on<DashboardEventSubmit>(_callDashboardAPI);
    on<DashboardSearchEvent>(_callSearchAPI);
    on<DashboardDetailsEvent>(_callDetailsAPI);
    on<FilterEventSubmit>(_callFilterAPI);
  }

  void _callDashboardAPI(DashboardEventSubmit event,
      Emitter<DashboardStates> emit) async {
    try {
      emit(DashboardLoadingState());
      final response = await appRepository.callDashboardAPI(event);
      if (response.getException == null) {
        emit(DashboardSuccessState(model: response.getData));
      }
      else {
        var error =
            await response.getException?.errorMessage ?? somethingWentWrong;
        if (error == noInternet) {
          emit(DashboardNetworkErrorState(error: error));
        } else {
          emit(DashboardErrorState(error: error));
        }
      }
    }
    on Exception catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

  void _callSearchAPI(DashboardSearchEvent event,
      Emitter<DashboardStates> emit) async {
    try {
      emit(DashboardLoadingState());
      final response = await appRepository.callSearchAPI(event);
      if (response.getException == null) {
        emit(DashboardSearchSuccessState(model: response.getData));
      }
      else {
        var error =
            await response.getException?.errorMessage ?? somethingWentWrong;
        if (error == noInternet) {
          emit(DashboardNetworkErrorState(error: error));
        } else {
          emit(DashboardErrorState(error: error));
        }
      }
    }
    on Exception catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }
  void _callFilterAPI(FilterEventSubmit event,
      Emitter<DashboardStates> emit) async {
    try {
      emit(DashboardLoadingState());
      final response = await appRepository.callFilterAPI(event);
      if (response.getException == null) {
        emit(FilterSuccessState(model: response.getData));
      }
      else {
        var error =
            await response.getException?.errorMessage ?? somethingWentWrong;
        if (error == noInternet) {
          emit(DashboardNetworkErrorState(error: error));
        } else {
          emit(DashboardErrorState(error: error));
        }
      }
    }
    on Exception catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

  void _callDetailsAPI(DashboardDetailsEvent event,
      Emitter<DashboardStates> emit) async {
    try {
      emit(DashboardLoadingState());
      final response = await appRepository.callDetailsAPI(event);
      if (response.getException == null) {
        emit(DashboardDetailsSuccessState(model: response.getData));
      }
      else {
        var error =
            await response.getException?.errorMessage ?? somethingWentWrong;
        if (error == noInternet) {
          emit(DashboardNetworkErrorState(error: error));
        } else {
          emit(DashboardErrorState(error: error));
        }
      }
    }
    on Exception catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

}

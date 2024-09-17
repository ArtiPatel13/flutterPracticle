
import 'package:dio/dio.dart';
import 'package:flutter_practicle/bloc/events/login_event.dart';
import 'package:flutter_practicle/model/listing_model.dart';

import '../../../repository/app_dio.dart';
import '../../../repository/data_source_manager/response_wrapper.dart';
import '../../../repository/data_source_manager/server_error.dart';
import '../../../repository/end_points.dart';
import '../bloc/events/dashboard_event.dart';
import '../model/details_model.dart';
import '../model/login_model.dart';

class LoginRepo{
  Future<ResponseWrapper<LoginModel>> callLoginAPI(LoginEventSubmit event) async {
    var responseWrapper = ResponseWrapper<LoginModel>();
    try {
      final Response loginResponse = await AppDio.instance.post(Endpoints.login, data:
      {
        "username": event.userName,
        "password": event.password,
        "expiresInMins": 60// optional, defaults to 60
      });
      if (loginResponse.data.isNotEmpty) {
        final data = LoginModel.fromJson(loginResponse.data);
        return responseWrapper..setData(data);
      }
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception catch (error) {
      responseWrapper.setException(ServerError.withError(error: error));
    }
    return responseWrapper;
  }

  Future<ResponseWrapper<ListingModel>> callDashboardAPI(DashboardEventSubmit event) async {
    var responseWrapper = ResponseWrapper<ListingModel>();
    try {
      final Response loginResponse = await AppDio.instance.get(Endpoints.listing,);
      if (loginResponse.data.isNotEmpty) {
        final data = ListingModel.fromJson(loginResponse.data);
        return responseWrapper..setData(data);
      }
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception catch (error) {
      responseWrapper.setException(ServerError.withError(error: error));
    }
    return responseWrapper;
  }
  Future<ResponseWrapper<ListingModel>> callSearchAPI(DashboardSearchEvent event) async {
    var responseWrapper = ResponseWrapper<ListingModel>();
    try {
      final Response loginResponse = await AppDio.instance.get(Endpoints.search,queryParameters: {
        "q": event.searchValue
      });
      if (loginResponse.data.isNotEmpty) {
        final data = ListingModel.fromJson(loginResponse.data);
        return responseWrapper..setData(data);
      }
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception catch (error) {
      responseWrapper.setException(ServerError.withError(error: error));
    }
    return responseWrapper;
  }
  Future<ResponseWrapper<ListingModel>> callFilterAPI(FilterEventSubmit event) async {
    var responseWrapper = ResponseWrapper<ListingModel>();
    try {
      final Response loginResponse = await AppDio.instance.get(Endpoints.filter,queryParameters:event.request);
      if (loginResponse.data.isNotEmpty) {
        final data = ListingModel.fromJson(loginResponse.data);
        return responseWrapper..setData(data);
      }
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception catch (error) {
      responseWrapper.setException(ServerError.withError(error: error));
    }
    return responseWrapper;
  }

  Future<ResponseWrapper<DetailsModel>> callDetailsAPI(DashboardDetailsEvent event) async {
    var responseWrapper = ResponseWrapper<DetailsModel>();
    try {
      final Response loginResponse = await AppDio.instance.get('${Endpoints.listing}/${event.id}',);
      if (loginResponse.data.isNotEmpty) {
        final data = DetailsModel.fromJson(loginResponse.data);
        return responseWrapper..setData(data);
      }
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception catch (error) {
      responseWrapper.setException(ServerError.withError(error: error));
    }
    return responseWrapper;
  }




}
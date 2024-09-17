import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../constant/strings.dart';
import '../base_model.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = somethingWentWrong;

  ServerError.withError({ dynamic error}){
    _handleError(error!);
  }

  int get errorCode {
    return _errorCode ?? 0;
  }

  Future<String> get errorMessage async {
    var isConnected = await checkConnection();
    if(!isConnected){
      _errorMessage = noInternet;
    }
    return _errorMessage;
  }

  static Future<bool> checkConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch(connectivityResult){
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.bluetooth:
        return false;
      case ConnectivityResult.ethernet:
        return false;
      case ConnectivityResult.vpn:
        return false;
      case ConnectivityResult.other:
        return false;
    }
  }

  Future<String> _handleError(DioError? error) async {

    print('#### error : $error');
    if(error == null) {
      _errorMessage = somethingWentWrong;
      return _errorMessage;
    }
    if(error.requestOptions == null) {
      _errorMessage = somethingWentWrong;
      return _errorMessage;
    }

    print('### API : ${error.requestOptions.uri}');
    print('### Method : ${error.requestOptions.method}');
    print('### Parameters : ${error.requestOptions.data}');
    print('### queryParameters : ${error.requestOptions.queryParameters}');
    print('### statusCode : ${error.response?.statusCode} ');
    print('### headers : ${error.requestOptions.headers} ');
    print('### statusMessage : ${error.response?.statusMessage} ');
    print('### response : ${error.response} ');
    print('### response.data : ${error.response?.data} ');
    print('### _handleError : ${error.toString()} ');
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = 'Request was cancelled';
        break;
      case DioErrorType.connectionTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioErrorType.unknown:
        if(error.response != null) {
          _errorMessage = error.response!.statusMessage!;
        }
        //_errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = 'Receive timeout in connection';
        break;
      /*case DioErrorType.response:
        if(error.response != null) {
          var msg = _handleServerError(error.response!);
          print('msg ---- > $msg');
          if (msg!.isEmpty) {
            msg = error.toString();
          }
          _errorMessage  = msg;
        }
        break;*/
      case DioErrorType.sendTimeout:
        _errorMessage = 'Receive timeout in send request';
        break;
      case DioErrorType.badCertificate:
        _errorMessage = 'bad certificate';
        break;
      case DioErrorType.badResponse:
        if(error.response != null) {
          var msg = _handleServerError(error.response!);
          print('msg ---- > $msg');
          if (msg.isEmpty) {
            msg = error.toString();
          }
          _errorMessage  = msg;
        }
        break;
      case DioErrorType.connectionError:
         _errorMessage = 'connection error';
        break;
    }
    if(_errorMessage.isEmpty) {
      _errorMessage = somethingWentWrong;
    }
    return _errorMessage;
  }

   String _handleServerError(Response? response) {
     _errorCode = response?.statusCode ?? 0;
    if(response == null){
      return somethingWentWrong;
    }
    else if (response.statusCode == 401) {
      final data = BaseModel.fromJson(response.data);
      return data.message ?? somethingWentWrong;
    }
    else if (response.runtimeType == String) {
      return response.toString();
    }
    else if (response.data != null && response.data.runtimeType  ==  String) {
      return response.data;
    }
    else if (response.data != null) {
      return response.data.toString();
    }
    return '';
  }
}
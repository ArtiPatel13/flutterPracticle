import 'server_error.dart';

class ResponseWrapper<T> {
  ServerError? _error;
  T? _data;

  // ignore: type_annotate_public_apis, always_declare_return_types
  setException(ServerError error) {
    _error = error;
  }

  // ignore: use_setters_to_change_properties
  void setData(T data) {
    _data = data;
  }

  T get getData => _data!;

  ServerError? get getException => _error;

  bool get hasException => _error != null;

  bool get hasData => _data != null;
}

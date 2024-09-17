
class Endpoints {
  Endpoints._();


  static const String baseUrl = "https://dummyjson.com/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(minutes:2);

  // connectTimeout
  static const Duration connectionTimeout = Duration(minutes:2);

  static const String login= 'user/login';
  static const String listing= 'users';
  static const String search= 'users/search';
  static const String filter= 'users/filter';
}

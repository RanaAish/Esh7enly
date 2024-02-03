import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = Dio();
  //dio.options.baseUrl = "http://api.e-esh7nly.net:7443/merchant/v1/";
  dio.options.baseUrl = "http://e-esh7nly.org/merchant/v1/";
  dio.options.headers['accept'] = 'application/json';
  dio.options.responseType = ResponseType.json;
  dio.options.contentType = Headers.jsonContentType;

  return dio;
}

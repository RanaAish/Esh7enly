import 'package:dio/dio.dart';

Dio xpaydio() {
  Dio dio = Dio();
  //dio.options.baseUrl = "http://api.e-esh7nly.net:7443/merchant/v1/";
  dio.options.baseUrl = "https://community.xpay.app/api/v1/";
  dio.options.headers['accept'] = 'application/json';
  dio.options.responseType = ResponseType.json;
  dio.options.contentType = Headers.jsonContentType;

  return dio;
}

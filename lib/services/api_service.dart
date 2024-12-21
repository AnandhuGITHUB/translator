import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl:
            "https://google-translate1.p.rapidapi.com/language/translate/v2",
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 3000),
        headers: {
          'x-rapidapi-key':
              '47dcd76efdmshb98462b17f86454p181723jsna3268ab3fa62',
          'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept-Encoding': 'application/gzip'
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("Request: ${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("Response: ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint("Error: ${error.response?.statusCode} ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await dio.post(endpoint, data: data);
  }
}

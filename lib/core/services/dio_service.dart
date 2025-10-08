import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'api_service.dart';

class DioService extends ApiService {
  final Dio _dio;

  DioService({String? baseUrl, String? token})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? ApiConstants.dummyJsonBaseUrl,
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // GET
  @override
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(endpoint, queryParameters: queryParams);
  }

  // POST
  @override
  Future<Response> post(String endpoint, {dynamic data}) async {
    return await _dio.post(endpoint, data: data);
  }

  // PUT
  @override
  Future<Response> put(String endpoint, {dynamic data}) async {
    return await _dio.put(endpoint, data: data);
  }

  // PATCH
  @override
  Future<Response> patch(String endpoint, {dynamic data}) async {
    return await _dio.patch(endpoint, data: data);
  }

  // DELETE
  @override
  Future<Response> delete(String endpoint, {dynamic data}) async {
    return await _dio.delete(endpoint, data: data);
  }
}

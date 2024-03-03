import 'dart:io';

import 'package:deeznote/config/main_config.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/response_model.dart';

/// Risen Core API
///
/// This class is used to call API from Risen Core
class RsAPI {
  RsAPI._();

  static final instance = RsAPI._();

  final Dio _dio = Dio(BaseOptions(
      baseUrl: MainConfig().baseURL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json));

  /// GET METHOD
  /// Get list of data from API with return data type list<dynamic>
  Future<ResponseModel> list(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      String? page,
      String? limit,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? extraParam,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.get(endpoint,
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: {'page': page, 'limit': limit, ...extraParam!},
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Get detail data from API with return data type Map<String, dynamic>
  /// [id] is required
  Future<ResponseModel> show(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      String? id,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.get('$endpoint/$id',
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Normal get data from API with return data type Map<String, dynamic>
  Future<ResponseModel> get(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.get(endpoint,
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// POST METHOD
  ///
  /// Post data to API with return data type ResponseModel (success, message, data)
  ///
  /// [data] is required
  Future<ResponseModel> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      String? token,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.post(endpoint,
          options: Options(
            headers: {
              'authorization': token,
            },
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Upload file to API with return data type ResponseModel (success, message, data)
  /// [file] is required
  /// [mediaType] is required
  Future<ResponseModel> upload(
      {required String endpoint,
      required File file,
      required MediaType mediaType,
      String? token,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var data = FormData();
      data.files.add(MapEntry(
        "file",
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
          contentType: mediaType,
        ),
      ));
      final res = await _dio.post(endpoint,
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// PUT METHOD
  /// Update data to API with return data type ResponseModel (success, message, data)
  /// [id] is required
  /// [data] is required
  Future<ResponseModel> put(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      String? id,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.put('$endpoint/$id',
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH METHOD
  /// Update partial data to API with return data type ResponseModel (success, message, data)
  /// [id] is required
  /// [data] is required
  Future<ResponseModel> patch(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      String? id,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.patch('$endpoint/$id',
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE METHOD
  /// Delete data from API with return data type ResponseModel (success, message, data)
  /// [id] is required
  Future<ResponseModel> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      String? token,
      String? id,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final res = await _dio.patch('$endpoint/$id',
          options: Options(
            headers: {'authorization': token, ...otherOptions!},
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data['data']);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }
}

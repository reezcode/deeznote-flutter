import 'dart:io';

import 'package:deeznote/common/utils/file.dart';
import 'package:http/http.dart' as http;
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:deeznote/config/main_config.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/response_model.dart';

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
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
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
      final res = await _dio.get('$endpoint/$id/show',
          options: Options(
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
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
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
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

  /// Normal get data from API with return data type Map<String, dynamic>
  // Future<dynamic> download(
  //     {required String endpoint,
  //     Map<String, dynamic>? data,
  //     String? token,
  //     Map<String, dynamic>? otherOptions,
  //     Map<String, dynamic>? queryParameters,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress}) async {
  //   try {
  //     final savePath = await FileHelper().getDownloadPath();
  //     final res = await _dio.download(endpoint, savePath,
  //         options: Options(
  //           headers: {
  //             'authorization': token,
  //             if (otherOptions != null) ...otherOptions
  //           },
  //         ));
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       return savePath;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  // Future<void> download({
  //   required String url,
  //   required String jwtToken,
  // }) async {
  //   Dio dio = Dio();
  //   dio.options.headers['Authorization'] = 'Bearer $jwtToken';

  //   try {
  //     Directory? downloadsDirectory = await getExternalStorageDirectory();
  //     if (downloadsDirectory == null) {
  //       throw FileSystemException('Failed to get downloads directory.');
  //     }
  //     String fileName = url.split('/').last;
  //     String? savePath = await FileHelper().getDownloadPath();
  //     savePath = '$savePath/$fileName.pdf';
  //     Response response = await dio.download(url, savePath,
  //         onReceiveProgress: (received, total) {
  //       if (total != -1) {
  //         print('Received: ${received / total * 100}%');
  //       }
  //     });
  //     RsToast.show(
  //         'Success', 'File downloaded successfully in Downloads folder.');
  //   } catch (error) {
  //     print('Failed to download file: $error');
  //   }
  // }

  Future<void> download({
    required String url,
    required String jwtToken,
  }) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $jwtToken';

    try {
      // Get the downloads directory for default fallback
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory == null) {
        throw FileSystemException('Failed to get downloads directory.');
      }

      // Use File Picker to choose a custom save location
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        throw Exception('No directory selected');
      }

      String fileName = url.split('/').last;
      String savePath = '$selectedDirectory/$fileName.pdf';

      Response response = await dio.download(url, savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Received: ${received / total * 100}%');
        }
      });

      RsToast.show(
          'Success', 'File downloaded successfully to $selectedDirectory.');
    } catch (error) {
      print('Failed to download file: $error');
      RsToast.show('Error', 'Failed to download file: $error');
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
      MediaType? mediaType,
      String? token,
      Map<String, dynamic>? otherOptions,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var data = FormData();
      data.files.add(MapEntry(
        "files",
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
          contentType: mediaType,
        ),
      ));
      final res = await _dio.post(endpoint,
          options: Options(
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
            contentType: 'multipart/form-data',
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
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
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
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
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
      final res = await _dio.delete('$endpoint/$id',
          options: Options(
            headers: {
              'authorization': token,
              if (otherOptions != null) ...otherOptions
            },
            contentType: 'application/json',
          ),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ResponseModel.fromJson(res.data);
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }
}

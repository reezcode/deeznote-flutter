import 'package:dio/dio.dart';
import '../../../../../common/widgets/rs_turing.dart';

class RsInterceptor {
  static void show(dynamic e) {
    if (e.response != null) {
      RsToast.show('Error!😓', '${e.response!.data['error_message']}!');
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      RsToast.show('Timeout!😓', 'Check your Internet Connection');
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      RsToast.show('Timeout!😓', 'Check your Internet Connection');
    }
  }
}

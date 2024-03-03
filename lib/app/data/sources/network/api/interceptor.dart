import 'package:dio/dio.dart';
import '../../../../../common/widgets/rs_turing.dart';

class RsInterceptor {
  static void show(dynamic e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      RsToast.show('Timeout!😓', 'Check your Internet Connection');
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      RsToast.show('Timeout!😓', 'Check your Internet Connection');
    }
    if (e.type == DioExceptionType.badCertificate) {
      RsToast.show('Error!😓', 'Bad Certificate');
    }
    if (e.type == DioExceptionType.cancel) {
      RsToast.show('Error!😓', 'Request Cancelled');
    }
    if (e.type == DioExceptionType.badResponse) {
      RsToast.show('Error!😓', 'Bad Response');
    }
    if (e.response != null) {
      RsToast.show('Error!😓', '${e.response!.data['error_message']}!');
    }
  }
}

import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/domain/repositories/user_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/endpoints_config.dart';
import '../../data/sources/network/api/interceptor.dart';
import '../../data/sources/network/api/rs_core_api.dart';
import '../../routes/app_pages.dart';

class UserRepository implements UserAbstractRepository {
  @override
  Future<void> detail(
      {required int id, required Function(Map<String, dynamic> p1) callback}) {
    // TODO: implement detail
    throw UnimplementedError();
  }

  @override
  Future<void> login(
      {
      /// Callback data that contain login information in Map<String, dynamic>
      required Function(Map<String, dynamic> p1) callback,
      required Map<String, dynamic> data}) async {
    EasyLoading.show();
    try {
      final res = await RsAPI.instance.post(
          endpoint: Endpoint.login,
          data: {"identifier": data['email'], "password": data['password']});
      if (res.data != null) {
        res.data['token'].toString().save('token');
        (res.data as Map<String, dynamic>).save('user_detail');
        Get.offAllNamed(Routes.HOME, arguments: {});
        callback(res.data);
        EasyLoading.dismiss();
      }
    } catch (e) {
      RsInterceptor.show(e);
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  @override
  Future<void> update(
      {required int id,
      required Function(Map<String, dynamic> p1) callback,
      required Map<String, dynamic> data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

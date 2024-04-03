import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/data/sources/network/api/interceptor.dart';
import 'package:deeznote/app/data/sources/network/api/rs_core_api.dart';
import 'package:deeznote/app/domain/repositories/notulensi_repository.dart';
import 'package:deeznote/config/endpoints_config.dart';
import 'package:deeznote/config/main_config.dart';

class NotulensiRepository extends NotulensiAbstractRepository {
  @override
  Future<Map> create(
      {required String meetId,
      required String notulensiTitle,
      required String notulensiContent,
      required String notulensiSignPIC,
      required String notulensiSignCust,
      required List<String> dokumentasi}) async {
    try {
      final res = await RsAPI.instance.post(
          endpoint: Endpoint.createNotulensi,
          data: {
            "meetIdMeet": meetId,
            "notulensiTitle": notulensiTitle,
            "notulensiContent": notulensiContent,
            "notulensiSignPIC": notulensiSignPIC,
            "notulensiSignCust": notulensiSignCust,
            "dokumentasi": dokumentasi,
            "createdBy": 'token'.load()
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<Map> show({required String id}) async {
    try {
      final res = await RsAPI.instance.get(
        endpoint: "${Endpoint.showNotulensi}/$id",
        token: 'Bearer ${'token'.load()}',
      );
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<Map> update(
      {required String id,
      String? meetIdMeet,
      String? notulensiTitle,
      String? notulensiContent,
      String? notulensiSignPIC,
      String? notulensiSignCust,
      List<String>? documents}) async {
    try {
      final res = await RsAPI.instance.patch(
          endpoint: Endpoint.updateNotulensi,
          id: id,
          data: {
            if (meetIdMeet != null) "meetIdMeet": meetIdMeet,
            if (notulensiTitle != null) "notulensiTitle": notulensiTitle,
            if (notulensiContent != null) "notulensiContent": notulensiContent,
            if (notulensiSignPIC != null) "notulensiSignPIC": notulensiSignPIC,
            if (notulensiSignCust != null)
              "notulensiSignCust": notulensiSignCust,
            if (documents != null) "dokumentasi": documents
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future download({required String id}) async {
    try {
      await RsAPI.instance.download(
        url: "${MainConfig().baseURL}${Endpoint.downloadNotulensi}/$id",
        jwtToken: '${'token'.load()}',
      );
    } catch (e) {
      RsInterceptor.show(e);
    }
  }
}

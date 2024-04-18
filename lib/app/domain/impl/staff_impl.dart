import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/data/sources/network/api/interceptor.dart';
import 'package:deeznote/app/data/sources/network/api/rs_core_api.dart';
import 'package:deeznote/app/domain/repositories/staff_repository.dart';
import 'package:deeznote/config/endpoints_config.dart';

class StaffRepository implements StaffAbstractRepository {
  @override
  Future<List> list(
      {String? search,
      int? page,
      int? limit,
      String? sort,
      String? sortBy}) async {
    try {
      final res = await RsAPI.instance.get(
          endpoint: Endpoint.staffList,
          queryParameters: {
            'name': search,
            'page': page,
            'limit': limit,
            'sort': sort,
            'sortBy': sortBy
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return [];
  }
}

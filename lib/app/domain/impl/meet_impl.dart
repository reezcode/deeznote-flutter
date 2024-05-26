import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/data/sources/network/api/interceptor.dart';
import 'package:deeznote/app/data/sources/network/api/rs_core_api.dart';
import 'package:deeznote/app/domain/repositories/meet_repository.dart';
import 'package:deeznote/config/endpoints_config.dart';

class MeetRepository implements MeetAbstractRepository {
  @override
  Future<Map> create(
      {required String meetTitle,
      String? meetLink,
      String? alternativeLocation,
      required String meetDate,
      required String projectName,
      String? officeId,
      required int meetReminder,
      required List involvedStaff,
      required String customerName,
      required String customerEmail,
      List? attachment}) async {
    try {
      final res = await RsAPI.instance.post(
          endpoint: Endpoint.createMeet,
          data: {
            'meetTitle': meetTitle,
            "projectName": projectName,
            'meetLink': meetLink,
            'meetDate': meetDate,
            'idOfficeLocations': officeId,
            'alternativeLocation': alternativeLocation,
            'meetReminder': meetReminder,
            'users': involvedStaff,
            'customerName': customerName,
            'customerEmail': customerEmail,
            'fileAttachment': attachment,
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<List> list(
      {String? search,
      String? startDate,
      String? endDate,
      int? page,
      int? limit,
      int? statusMeetCode,
      String? sort,
      String? sortBy}) async {
    try {
      final res = await RsAPI.instance.get(
          endpoint: Endpoint.meetList,
          queryParameters: {
            'search': search,
            'page': page,
            'limit': limit,
            'sort': sort,
            'sortBy': sortBy,
            'startDate': startDate,
            if (statusMeetCode != null) 'statusMeetCode': statusMeetCode,
            'endDate': endDate
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return [];
  }

  @override
  Future<Map> show({required String id}) async {
    try {
      final res = await RsAPI.instance.get(
          endpoint: '${Endpoint.showMeet}/$id',
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<int?> delete({required String id}) async {
    try {
      final res = await RsAPI.instance.delete(
          endpoint: Endpoint.deleteMeet,
          id: id,
          token: 'Bearer ${'token'.load()}');
      if (res.status == 200) return res.status;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return 400;
  }

  @override
  Future<Map> update(
      {required String id,
      required String meetTitle,
      String? meetLink,
      String? alternativeLocation,
      required String meetDate,
      required String projectName,
      String? officeId,
      required int meetReminder,
      required List involvedStaff,
      required String customerName,
      required String customerEmail,
      List? attachment}) async {
    try {
      final res = await RsAPI.instance.patch(
          endpoint: Endpoint.updateMeet,
          id: id,
          data: {
            'meetTitle': meetTitle,
            "projectName": projectName,
            'meetLink': meetLink,
            'meetDate': meetDate,
            'idOfficeLocations': officeId,
            'alternativeLocation': alternativeLocation,
            'meetReminder': meetReminder,
            'users': involvedStaff,
            'customerName': customerName,
            'customerEmail': customerEmail,
            'fileAttachment': attachment,
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<Map> dashboard(
      {String? sort,
      String? sortBy,
      String? startDate,
      int? page,
      int? limit,
      String? endDate}) async {
    try {
      final res = await RsAPI.instance.get(
          endpoint: Endpoint.dashboard,
          queryParameters: {
            'sort': sort,
            'sortBy': sortBy,
            'startDate': startDate,
            'endDate': endDate,
            'page': page,
            'limit': limit
          },
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }

  @override
  Future<Map> finish({required String id}) async {
    try {
      final res = await RsAPI.instance.patch(
          endpoint: Endpoint.finishMeet,
          id: id,
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) return res.data;
    } catch (e) {
      RsInterceptor.show(e);
    }
    return {};
  }
}

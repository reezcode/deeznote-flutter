abstract class MeetAbstractRepository {
  Future<Map> create({
    required String meetTitle,
    String? meetLink,
    required String meetDate,
    required String officeId,
    required int meetReminder,
    required List involvedStaff,
    required String customerName,
    List? attachment,
  });

  Future<List> list({
    String? search,
    int? page,
    int? limit,
    String? sort,
    String? sortBy,
    String? startDate,
    String? endDate,
  });

  Future<Map> show({
    required String id,
  });

  Future<Map> update({
    required String id,
    required String meetTitle,
    String? meetLink,
    required String meetDate,
    required String officeId,
    required int meetReminder,
    required List involvedStaff,
    required String customerName,
    List? attachment,
  });

  Future<Map> delete({
    required String id,
  });

  Future<Map> dashboard(
      {String? sort, String? sortBy, String? startDate, String? endDate});

  Future<Map> finish({required String id});
}

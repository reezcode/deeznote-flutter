abstract class MeetAbstractRepository {
  Future<void> list({
    String? date,
    String? limit,
    String? page,
    required Function(List<dynamic>) callback,
  });

  Future<void> detail({
    required int id,
    required Function(Map<String, dynamic> p1) callback,
  });

  Future<void> create({
    required Function(Map<String, dynamic> p1) callback,
    required Map<String, dynamic> data,
  });

  Future<void> update({
    required int id,
    required Function(Map<String, dynamic> p1) callback,
    required Map<String, dynamic> data,
  });

  Future<void> delete({
    required int id,
    required Function(Map<String, dynamic> p1) callback,
  });
}

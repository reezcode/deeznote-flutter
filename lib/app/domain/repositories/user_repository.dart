abstract class UserAbstractRepository {
  Future<void> login(
      {required Function(Map<String, dynamic>) callback,
      required Map<String, dynamic> data});

  Future<void> detail({
    required String id,
    required Function(Map<String, dynamic>) callback,
  });

  Future<Map> update({
    required String id,
    required Map<String, dynamic> data,
  });

  Future<bool> changePassword({
    required String id,
    required Map<String, dynamic> data,
  });
}

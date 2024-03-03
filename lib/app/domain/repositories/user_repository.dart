abstract class UserAbstractRepository {
  Future<void> login(
      {required Function(Map<String, dynamic>) callback,
      required Map<String, dynamic> data});

  Future<void> detail({
    required int id,
    required Function(Map<String, dynamic>) callback,
  });

  Future<void> update({
    required int id,
    required Function(Map<String, dynamic>) callback,
    required Map<String, dynamic> data,
  });
}

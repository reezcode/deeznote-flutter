abstract class StaffAbstractRepository {
  Future<void> list({
    String? search,
    required Function(List<dynamic>) callback,
  });
}

abstract class StaffAbstractRepository {
  Future<List> list({
    String? search,
    int? page,
    int? limit,
    String? sort,
    String? sortBy,
  });
}

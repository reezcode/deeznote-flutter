import 'package:deeznote/app/domain/repositories/meet_repository.dart';

class MeetRepository implements MeetAbstractRepository {
  @override
  Future<void> create(
      {required Function(Map<String, dynamic> p1) callback,
      required Map<String, dynamic> data}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(
      {required int id, required Function(Map<String, dynamic> p1) callback}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> detail(
      {required int id, required Function(Map<String, dynamic> p1) callback}) {
    // TODO: implement detail
    throw UnimplementedError();
  }

  @override
  Future<void> list(
      {String? date,
      String? limit,
      String? page,
      required Function(List p1) callback}) {
    // TODO: implement list
    throw UnimplementedError();
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

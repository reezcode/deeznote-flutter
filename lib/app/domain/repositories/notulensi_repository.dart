abstract class NotulensiAbstractRepository {
  Future<Map> create(
      {required String meetId,
      required String notulensiTitle,
      required String notulensiContent,
      required String notulensiSignPIC,
      required String notulensiSignCust,
      required List<String> dokumentasi});

  Future<Map> show({
    required String id,
  });

  Future<Map> update(
      {required String id,
      String? meetIdMeet,
      String? notulensiTitle,
      String? notulensiContent,
      String? notulensiSignPIC,
      String? notulensiSignCust,
      List<String>? documents});

  Future<dynamic> download({
    required String id,
  });
}

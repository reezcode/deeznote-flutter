extension NullHandler on String? {
  String get ns => this ?? 'Data not found';
}

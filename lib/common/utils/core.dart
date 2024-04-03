dynamic when(dynamic value, Map<dynamic, Function> cases) {
  if (cases.containsKey(value)) {
    return cases[value]!();
  } else if (cases.containsKey('else')) {
    return cases['else']!();
  } else {
    throw ArgumentError('No matching case found');
  }
}

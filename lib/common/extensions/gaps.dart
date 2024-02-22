import 'package:flutter/material.dart';

extension GapExtension on Widget {
  /// Horizontal gap with value 4.0
  Widget get xxsW => const SizedBox(width: 4.0);

  /// Horizontal gap with value 8.0
  Widget get xsW => const SizedBox(width: 8.0);

  /// Horizontal gap with value 16.0
  Widget get sW => const SizedBox(width: 16.0);

  /// Horizontal gap with value 32.0
  Widget get mW => const SizedBox(width: 32.0);

  /// Horizontal gap with value 64.0
  Widget get lW => const SizedBox(width: 64.0);

  /// Horizontal gap with value 128.0
  Widget get xlW => const SizedBox(width: 128.0);

  /// Horizontal gap with value 256.0
  Widget get xxlW => const SizedBox(width: 256.0);

  /// Vertical gap with value 4.0
  Widget get xxsH => const SizedBox(height: 4.0);

  /// Vertical gap with value 8.0
  Widget get xsH => const SizedBox(height: 8.0);

  /// Vertical gap with value 16.0
  Widget get sH => const SizedBox(height: 16.0);

  /// Vertical gap with value 32.0
  Widget get mH => const SizedBox(height: 32.0);

  /// Vertical gap with value 64.0
  Widget get lH => const SizedBox(height: 64.0);

  /// Vertical gap with value 128.0
  Widget get xlH => const SizedBox(height: 128.0);

  /// Vertical gap with value 256.0
  Widget get xxlH => const SizedBox(height: 256.0);
}

extension GapExtensionNumber on int {
  /// Horizontal gap with n
  Widget get gW => SizedBox(width: toDouble());

  /// Vertical gap with n
  Widget get gH => SizedBox(height: toDouble());
}

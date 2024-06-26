import 'package:flutter/material.dart';

import '../widgets/custom/custom_shimmer.dart';

extension RsLoader on Widget {
  Widget loader(bool loading) {
    return !loading ? this : const DoubleLongShimmer();
  }
}

extension RsLoader2 on List<Widget> {
  List<Widget> loader({required bool loading, int? count}) {
    return !loading
        ? this
        : [
            ListLongShimmer(
              count: count,
            )
          ];
  }
}

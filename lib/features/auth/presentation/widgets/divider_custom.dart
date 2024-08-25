/* Flutter Imports */

import 'package:flutter/material.dart';
import 'package:union/core/themes/palette.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Palette.disabled,
      height: 40,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}

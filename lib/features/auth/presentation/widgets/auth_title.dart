/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/themes/palette.dart';

class AuthTitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool visibleLogo;

  const AuthTitle({
    super.key,
    this.title,
    this.subtitle,
    this.visibleLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final String package = backgroundColor == Palette.background
        ? 'assets/icon/icon-light.png'
        : 'assets/icon/icon-dark.png';
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Visibility(
          visible: visibleLogo,
          child: ClipRRect(
            child: Image(image: AssetImage(package), height: 200),
          ),
        ),
        Visibility(
          visible: title != null,
          child: Text(
            title ?? '',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: subtitle != null,
          child: Text(
            subtitle ?? '',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}

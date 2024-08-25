/* Flutter Imports */
import 'package:flutter/material.dart';

class RedirectLink extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback onTap;

  const RedirectLink({
    super.key,
    required this.text,
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: text,
          style: textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' $link',
              style: textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

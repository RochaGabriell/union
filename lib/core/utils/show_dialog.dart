/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/common/widgets/alert.dart';
import 'package:union/core/enums/alert_type.dart';

void showMessageDialog(
  BuildContext context, {
  bool barrierDismissible = false,
  required String title,
  required String message,
  required AlertType type,
  VoidCallback? onConfirm,
  VoidCallback? onDismiss,
  VoidCallback? onRedirect,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return MessageDialog(
        title: title,
        message: message,
        type: type,
        onConfirm: onConfirm,
        onDismiss: onDismiss,
        onRedirect: onRedirect,
      );
    },
  );
}

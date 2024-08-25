/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/themes/palette.dart';

class MessageDialog extends StatefulWidget {
  final String title;
  final String message;
  final AlertType type;
  final VoidCallback? onConfirm;
  final VoidCallback? onDismiss;
  final VoidCallback? onRedirect;

  const MessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onConfirm,
    this.onDismiss,
    this.onRedirect,
  });

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    if (widget.onRedirect != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          widget.onRedirect!();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getColor() {
    switch (widget.type) {
      case AlertType.success:
        return Palette.success;
      case AlertType.error:
        return Palette.error;
      case AlertType.warning:
        return Palette.warning;
      default:
        return Palette.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Container(
        height: 80,
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: getColor().withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: getColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Visibility(
              visible: widget.onRedirect != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _controller.value,
                      valueColor: AlwaysStoppedAnimation(getColor()),
                      backgroundColor: getColor().withOpacity(0.1),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Visibility(
          visible: widget.onConfirm != null,
          child: TextButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              overlayColor:
                  WidgetStateProperty.all(getColor().withOpacity(0.1)),
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              widget.onConfirm!();
            },
            child: Text(
              'Confirmar',
              style: TextStyle(color: getColor()),
            ),
          ),
        ),
        Visibility(
          visible: widget.onDismiss != null,
          child: TextButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              overlayColor:
                  WidgetStateProperty.all(getColor().withOpacity(0.1)),
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              widget.onDismiss!();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: getColor()),
            ),
          ),
        ),
      ],
    );
  }
}

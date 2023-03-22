import 'package:flutter/material.dart';

class Popup {
  static dynamic popupResult;

  static Future<void> show(
    Widget child, {
    bool isDismissible = true,
    required BuildContext context,
  }) async {
    popupResult = null;
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(top: 0 + 24),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: child,
        ),
      ),
      anchorPoint: const Offset(100, 40),
    );
  }
}

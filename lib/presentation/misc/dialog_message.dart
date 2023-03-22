import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_dialog_button_pressed.dart';
import 'package:app_settings/app_settings.dart';

class DialogMessage {
  final String? title;
  final String body;
  final bool dontShowAgainTick;
  final List<DialogActionButton> actions;

  DialogMessage(
    this.title,
    this.body,
    this.actions, {
    this.dontShowAgainTick = false,
  });
}

class DialogActionButton {
  final String title;
  final Function(BuildContext) action;

  DialogActionButton._(this.title, this.action);

  static DialogActionButton get googlePlay =>
      DialogActionButton._("Google Play", (context) {
        LaunchApp.openApp(androidPackageName: "com.android.vending");
        Navigator.of(context).pop();
      });

  static DialogActionButton get restartApp =>
      DialogActionButton._("Restart", (context) {
        if (Platform.isAndroid) {
          Restart.restartApp();
        }
      });
  static DialogActionButton get close =>
      DialogActionButton._("Close", (context) {
        Navigator.of(context).pop();
      });
  static DialogActionButton get appSettings =>
      DialogActionButton._("App settings", (context) {
        if (Platform.isAndroid) {
          AppSettings.openAppSettings();
        }
        Navigator.of(context).pop();
      });

  Widget widget(BuildContext context) => TextButton(
        onPressed: () {
          Analytics.logEvent(EventDialogButtonPressed(title));
          action.call(context);
        },
        child: Text(
          title,
          textAlign: TextAlign.end,
        ),
      );
}

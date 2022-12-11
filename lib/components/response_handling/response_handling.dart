import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/components/dialogs/response_alert_dialog.dart';
import 'package:karemsacrifices/utils/app_colors.dart';

import 'package:toast/toast.dart';

handleUnauthenticated(BuildContext context) {
  showDialog(
      barrierDismissible: false, // user must tap button!
      context: context,
      builder: (_) {
        return ResponseAlertDialog(
          alertTitle: 'عفواً',
          alertMessage: 'يرجي تسجيل الدخول مجدداً',
          alertBtn: 'موافق',
          onPressedAlertBtn: () {
            Navigator.pop(context);
            SharedPreferencesHelper.remove("user");
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login_screen', (Route<dynamic> route) => false);
          },
        );
      });
}

showErrorDialog(var message, BuildContext context) {
  showDialog(
      barrierDismissible: false, // user must tap button!
      context: context,
      builder: (_) {
        return ResponseAlertDialog(
          alertTitle: 'عفواً',
          alertMessage: message,
          alertBtn: 'موافق',
          onPressedAlertBtn: () {},
        );
      });
}

showToast(String message, context ,{Color color}) {
  return Toast.show(message, context,
      backgroundColor:color == null ? cPrimaryColor : color,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM);
}

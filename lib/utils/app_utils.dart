import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils instance = AppUtils._privateConstructor();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  Future<bool> showAlertDialog({
    required title,
    required description,
    required positiveText,
    required negativeText,
    required BuildContext context,
    required Function onPressed,
  }) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: <Widget>[
                TextButton(
                  child: Text(negativeText),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPressed(false);
                  },
                ),
                TextButton(
                  child: Text(positiveText),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPressed(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

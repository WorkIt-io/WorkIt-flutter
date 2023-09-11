import 'package:flutter/material.dart';
import 'package:workit/common/loader.dart';

void startLoadingDialog(BuildContext context, {bool isDismiss = false}) {
  showDialog(
    context: context,
    barrierDismissible: isDismiss,
    barrierColor: Colors.black87,
    builder: (context) {
      return const Loader();
    },
  );
}

void startErrorDialog(BuildContext context,
    {required String title, required String text}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    builder: (ctx) => AlertDialog(
      contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
      title: Text(title),
      content: text.startsWith('Exception: ')
          ? Text(
              text.substring(10),
              textAlign: TextAlign.center,
            )
          : Text(
              text,
              textAlign: TextAlign.center,
            ),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      actions: [
        ElevatedButton(
            onPressed: Navigator.of(context).pop, child: const Text("OK"))
      ],
    ),
  );
}

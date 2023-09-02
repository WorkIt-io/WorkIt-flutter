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

void startErrorDialog(BuildContext context, {required String title, required String text}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    builder: (ctx) => AlertDialog(      
      title: Text(title),
      content: Text(text),
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

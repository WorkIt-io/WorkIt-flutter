import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: const CircularProgressIndicator()));
  }
}

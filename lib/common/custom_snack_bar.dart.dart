
import 'package:flutter/material.dart';

class CustomSnackBar {  

  static void showSnackBar(BuildContext context, String text)
  {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), ));
  }  
}
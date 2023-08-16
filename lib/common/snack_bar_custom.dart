
import 'package:flutter/material.dart';

class SnakcBarCustom {  

  static void showSnackBar(BuildContext context, String text)
  {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), ));
  }  
}
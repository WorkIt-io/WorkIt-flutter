import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_snack_bar.dart.dart';

Future<File?> takeImageFromCamera(BuildContext context) async {
  ImagePicker imagePicker = ImagePicker();
  try {
    XFile? xfile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xfile == null) {
      return null;
    }
    return File(xfile.path); 
  } catch (e) {
    if (context.mounted) {
      CustomSnackBar.showSnackBar(context, 'Can\'t Upload Image.');
    }
    return null;
  }
}

Future<File?> selectImageFromGallery(BuildContext context) async {
  ImagePicker imagePicker = ImagePicker();
  try {
    XFile? xfile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xfile == null) {
      return null;
    }
    return File(xfile.path); 
  } catch (e) {
    if (context.mounted) {
      CustomSnackBar.showSnackBar(context, 'Can\'t Upload Image.');
    }
    return null;
  }
}

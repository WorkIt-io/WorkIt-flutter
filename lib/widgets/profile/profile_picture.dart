import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/select_image.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? profileImage;

  ImageProvider<Object> getProfileImage() {
    if (profileImage == null) {
      return const AssetImage("assets/images/blank-profile.png");
    } else {
      return FileImage(profileImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () async {
              File? image = await takeImageFromCamera(context);
              if (image != null) {
                setState(() => profileImage = image);
              }
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: getProfileImage(),
            )),
        const Positioned(right: 5, bottom: 0, child: Icon(Icons.add_a_photo)),
      ],
    );
  }
}

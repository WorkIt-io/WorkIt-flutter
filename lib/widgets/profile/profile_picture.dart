import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/select_image.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.profilePicture});

  final String? profilePicture;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? profileImage;

  ImageProvider<Object> getProfileImage() {
    final ImageProvider<Object> image;

    if (profileImage == null) {      
      if (widget.profilePicture != null) {
        image = NetworkImage(widget.profilePicture!);
      } else {
        image = const AssetImage("assets/images/blank-profile.png");
      }      
    } else {
      image = FileImage(profileImage!);
    }

    return image;
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

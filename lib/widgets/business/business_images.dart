import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/common/loader.dart';
import 'package:workit/common/select_image.dart';
import 'package:workit/controller/image_controller.dart';

class BusinessImages extends ConsumerStatefulWidget {
  const BusinessImages({super.key});

  @override
  ConsumerState<BusinessImages> createState() => _BusinessImagesState();
}

class _BusinessImagesState extends ConsumerState<BusinessImages> {
  List<String> images = [];
  final ImagePicker imagePicker = ImagePicker();
  int currentPageIndex = 0;
  late Future<List<String>> retriveAllImages;

  @override
  void initState() {
    super.initState();
    retriveAllImages = ref.read(imageControllerProvider).retriveAllImages();
  }

  Future<void> onUploadImagePress() async {
    File? imageFile = await selectImage(context);
    if (imageFile != null) {
      try {
        String url = await ref
            .read(imageControllerProvider)
            .uploadBussinesImage(imageFile);
        setState(() {
          images.add(url);
        });
      } catch (e) {
        if (context.mounted) {
          CustomSnackBar.showSnackBar(context, e.toString());
        }
      }
    }
  }

  Future<void> onDeleteImagePress() async {
    await ref.read(imageControllerProvider).removeLastImage();
    setState(() {
      currentPageIndex = currentPageIndex == images.length - 1
          ? currentPageIndex - 1
          : currentPageIndex;
      images.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: retriveAllImages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else if (snapshot.hasData) {
          images = snapshot.data!;
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: images.isEmpty
                    ? Text(
                        "No Images Yet.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    : PageView.builder(
                        itemCount: images.length,
                        onPageChanged: (index) => setState(() {
                          currentPageIndex = index;
                        }),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: images[index],
                                placeholder: (context, url) => Image.asset(
                                    'assets/images/workit_logo_no_bg.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (images.isNotEmpty)
                DotsIndicator(
                  dotsCount: images.length,
                  position: currentPageIndex,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                  //later change the buttons only bw shown by Admin of this page
                  onPressed: onUploadImagePress,
                  child: const Text('Add image')),
              const SizedBox(height: 6),
              ElevatedButton(
                  onPressed: images.isEmpty ? null : onDeleteImagePress,
                  child: const Text('Remove Last Image')),
            ],
          );
        } else {
          return const Text('Error loading images.');
        }
      },
    );
  }
}

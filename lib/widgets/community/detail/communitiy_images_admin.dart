import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/common/loader.dart';
import 'package:workit/common/select_image.dart';
import 'package:workit/providers/community/image_community_notifier.dart';

class CommunityImagesAdmin extends ConsumerStatefulWidget {
  const CommunityImagesAdmin({super.key});

  @override
  ConsumerState<CommunityImagesAdmin> createState() => _CommunityImagesState();
}

class _CommunityImagesState extends ConsumerState<CommunityImagesAdmin> {
  final ImagePicker imagePicker = ImagePicker();
  List<String> images = [];
  int currentPageIndex = 0;
  bool isManualCahnge = true;
  bool isDeleting = false;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    ref.read(imageCommunityNotifierProvider.notifier).retriveAllImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> onUploadImagePress(
      ImageSource source, BuildContext context) async {
    File? imageFile;
    if (context.mounted) {
      if (source == ImageSource.gallery) {
        imageFile = await selectImageFromGallery(context);
      } else {
        imageFile = await takeImageFromCamera(context);
      }
    }

    if (imageFile != null) {
      try {
        await ref
            .read(imageCommunityNotifierProvider.notifier)
            .uploadCommunityImage(imageFile);

        currentPageIndex = images.length;

        SchedulerBinding.instance.addPostFrameCallback((_) {
          isManualCahnge = false;
          _pageController
              .animateToPage(currentPageIndex,
                  duration: const Duration(seconds: 1), curve: Curves.linear)
              .then((value) => isManualCahnge = true);
        });

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          CustomSnackBar.showSnackBar(context, e.toString());
        }
      }
    }
  }

  Future<void> onLastDeleteImagePress() async {
    await ref.read(imageCommunityNotifierProvider.notifier).removeLastImage();

    if (currentPageIndex >= images.length - 1 && currentPageIndex != 0) {
      currentPageIndex = currentPageIndex - 1;
      isManualCahnge = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _pageController
            .animateToPage(currentPageIndex,
                duration: const Duration(seconds: 1), curve: Curves.linear)
            .then((value) => isManualCahnge = true);
      });
    }
  }

  void pickSourceImage() {
    bool isPicking = false;

    showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (btx) {
          return StatefulBuilder(
            builder: (context, setState) {
              if (isPicking == false) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton.icon(
                        onPressed: () async {
                          setState(() => isPicking = true);
                          await onUploadImagePress(
                              ImageSource.gallery, context);
                          if (context.mounted) {
                            setState(() => isPicking = false);
                          }
                        },
                        icon: const Icon(Icons.image),
                        label: const Text(
                          "Gallery",
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton.icon(
                        onPressed: () async {
                          setState(() => isPicking = true);
                          await onUploadImagePress(ImageSource.camera, context);
                          if (context.mounted) {
                            setState(() => isPicking = false);
                          }
                        },
                        icon: const Icon(Icons.camera_alt_sharp),
                        label: const Text("Camera",
                            style: TextStyle(fontSize: 20))),
                  ],
                );
              } else {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Loader()],
                );
              }
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    images = ref.watch(imageCommunityNotifierProvider);
    final isLoading =
        ref.read(imageCommunityNotifierProvider.notifier).isLoading;

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: isLoading == true
              ? const Loader()
              : images.isEmpty
                  ? Text(
                      "No Images Yet.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        if (isManualCahnge) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        }
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            placeholder: (context, url) => Image.asset(
                                'assets/images/workit_logo_no_bg.png'),
                            fit: BoxFit.cover,
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
            onPressed: pickSourceImage,
            child: const Text('Add image')),
        const SizedBox(height: 6),
        if (isDeleting == false)
          ElevatedButton(
              onPressed: isLoading == true || images.isEmpty
                  ? null
                  : () async {
                      setState(() {
                        isDeleting = true;
                      });
                      await onLastDeleteImagePress();
                      isDeleting = false;
                    },
              child: const Text('Remove Last Image')),
        if (isDeleting) const Loader(),
      ],
    );
  }
}

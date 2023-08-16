import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workit/api/storage_image_business_api.dart';
import 'package:workit/common/snack_bar_custom.dart';

class BusinessImages extends StatefulWidget {
  const BusinessImages({super.key});  

  @override
  State<BusinessImages> createState() => _BusinessImagesState();
}

class _BusinessImagesState extends State<BusinessImages> {
  List<String> images = [];
  final ImagePicker imagePicker = ImagePicker();
  int currentPageIndex = 0;
  late Future<List<String>> retriveAllImages;

  @override
  void initState() {
    super.initState();
    retriveAllImages = ImageBusinessApi.retriveAllImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: retriveAllImages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Container(margin: const EdgeInsets.all(8) , padding: const EdgeInsets.all(8),child: const CircularProgressIndicator()));
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
              ElevatedButton( //later change the buttons only bw shown by Admin of this page
                  onPressed: () async {
                    XFile? xfile =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    if (xfile != null) {
                      try {
                        String url = await ImageBusinessApi.uploadToFireBase(                            
                            fileName: "${images.length}.jpg",
                            image: File(xfile.path));
                        setState(() {
                          images.add(url);
                        });
                      } catch (e) {
                        if (context.mounted) {
                          SnakcBarCustom.showSnackBar(context, 'Can\'t Upload Image.');
                        }
                      }
                    }
                  },
                  child: const Text('Add image')),
              const SizedBox(height: 6),
              ElevatedButton(
                  onPressed: images.isEmpty
                      ? null
                      : () async {
                          await ImageBusinessApi.removeImage(fileIdToRemove: images.length - 1);
                          setState(() {
                            currentPageIndex =
                                currentPageIndex == images.length - 1
                                    ? currentPageIndex - 1
                                    : currentPageIndex;
                            images.removeLast();
                          });
                        },
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

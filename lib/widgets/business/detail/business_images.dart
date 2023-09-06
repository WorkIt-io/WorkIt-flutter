import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workit/common/loader.dart';
import 'package:workit/providers/business/image_business_notifier.dart';

class BusinessImages extends ConsumerStatefulWidget {
  const BusinessImages({super.key});

  @override
  ConsumerState<BusinessImages> createState() => _BusinessImagesState();
}

class _BusinessImagesState extends ConsumerState<BusinessImages> {
  final ImagePicker imagePicker = ImagePicker();
  List<String> images = [];
  int currentPageIndex = 0;    
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    ref.read(imageBusinessNotifierProvider.notifier).retriveAllImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    images = ref.watch(imageBusinessNotifierProvider);
    final isLoading =
        ref.read(imageBusinessNotifierProvider.notifier).isLoading;

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
                          setState(() {
                            currentPageIndex = index;
                          });                        
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
      ],
    );
  }
}

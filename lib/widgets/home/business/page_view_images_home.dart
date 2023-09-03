import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:workit/constant/home_images.dart';

class PageViewImagesHome extends StatefulWidget {
  const PageViewImagesHome({super.key});

  @override
  State<PageViewImagesHome> createState() => _PageViewImagesHomeState();
}

class _PageViewImagesHomeState extends State<PageViewImagesHome> {
  int currentPage = 0;
  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        if (currentPage == 2) {
          currentPage = 0;
        } else {
          currentPage = currentPage + 1;
        }
        if (pageController.hasClients) {
          pageController.animateToPage(currentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var imageAsset in homeImages) {
      precacheImage(AssetImage(imageAsset), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        ...List.generate(
          homeImages.length,
          (index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 200,
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(70)),
                ),
                child: Image.asset(
                  homeImages[index],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      homeTextImages[index],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent[400]),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      homeTextDescription[index],
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      style: const TextStyle(                        
                          fontSize: 18,
                          color: Colors.blueGrey),
                    ),
                    const Spacer(),
                    DotsIndicator(
                        position: currentPage, dotsCount: homeImages.length),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

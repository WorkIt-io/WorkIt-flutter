import 'package:flutter/material.dart';

import '../models/community.dart';

class Communities with ChangeNotifier {
  final List<Community> _communitiesList = [
    Community(
      id: "1",
      name: "Basketball",
      imageUrl:
          "https://profitgym.co.il/wp-content/themes/profit/assets/images/logo.png",
      description: "Playing 5v5",
      distance: 1.8,
    ),
    Community(
      id: "2",
      name: "Soccer in the hood",
      imageUrl:
          "https://lh5.googleusercontent.com/p/AF1QipPfNsva5ZmNTXNOxcTpPDfeqxIbp1RSR_SA1CWO=w408-h306-k-no",
      description: "Come and show what you've got",
      distance: 0.5,
    ),
    Community(
      id: "3",
      name: "Run - 5km",
      imageUrl:
          "https://cdn.imgbin.com/0/0/21/imgbin-rock-climbing-climbing-wall-simple-cool-rock-climbing-chart-man-mountain-climbing-D8Pw5Y7v2dMfVzxRs6XU3ysFt.jpg",
      description: "Running for rookies",
      distance: 2.1,
    ),
  ];

  List<Community> get businessesList {
    return [..._communitiesList];
  }
}

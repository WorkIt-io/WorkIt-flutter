import 'package:flutter/material.dart';

import '../models/business.dart';

class Businesses with ChangeNotifier {
  final List<Business> _businessesList = [
    Business(
      id: "1",
      name: "Profit - Tel Aviv",
      imageUrl:
          "https://profitgym.co.il/wp-content/themes/profit/assets/images/logo.png",
      description: "Gym and much more",
      rate: 4.9,
      distance: 1.8,
    ),
    Business(
      id: "2",
      name: "CrossFit Florentin",
      imageUrl:
          "https://lh5.googleusercontent.com/p/AF1QipPfNsva5ZmNTXNOxcTpPDfeqxIbp1RSR_SA1CWO=w408-h306-k-no",
      description: "Gym and much more",
      rate: 4.6,
      distance: 0.5,
    ),
    Business(
      id: "3",
      name: "Wall Climb",
      imageUrl:
          "https://cdn.imgbin.com/0/0/21/imgbin-rock-climbing-climbing-wall-simple-cool-rock-climbing-chart-man-mountain-climbing-D8Pw5Y7v2dMfVzxRs6XU3ysFt.jpg",
      description: "Come to climb with Netanel",
      rate: 5.0,
      distance: 2.1,
    ),
  ];

  List<Business> get businessesList {
    return [..._businessesList];
  }
}

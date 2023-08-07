import '../models/business.dart';
import '../models/community.dart';

class Businesses
{
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
    Business(
      id: "4",
      name: "Lazuz",
      imageUrl:
          "https://www.lazuzwellness.co.il/wp-content/uploads/2021/03/Lazuz-WEBSITE-FOOTER-7-e1616423799755.png",
      description: "Gym boutique",
      rate: 4.7,
      distance: 3.2,
    ),
    Business(
      id: "5",
      name: "Surf Club",
      imageUrl:
          "https://tahititourisme.com/wp-content/uploads/2019/07/Tom-Servais-Tahiti-Surf-Pro-2017servais17_0332781140x550px.jpg",
      description: "Surf and Enjoy!",
      rate: 4.3,
      distance: 5.1,
    ),
    Business(
      id: "5",
      name: "Tenis Club",
      imageUrl:
          "https://media.npr.org/assets/img/2023/05/31/gettyimages-1494855820_wide-123be6bf852a48ae17f13c963529d7d59391e10d-s1400-c100.jpg",
      description: "Tennis with Cohen",
      rate: 3.9,
      distance: 4.2,
    ),
  ];

  List<Business> get businessesList {
    return [..._businessesList];
  }
}



class Communities
{
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

  List<Community> get communitiesList {
    return [..._communitiesList];
  }
}

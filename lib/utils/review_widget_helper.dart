
import '../models/review.dart';

class ReviewWidgetHelper {
  
  static List<double> calcRatePerReview(List<Review> reviews) {
    List<double> reviewsPerRate = [0, 0, 0, 0, 0];

    for (var review in reviews) {
      if (review.rate == 1) {
        reviewsPerRate[0]++;
      } else if (review.rate == 2) {
        reviewsPerRate[1]++;
      } else if (review.rate == 3) {
        reviewsPerRate[2]++;
      } else if (review.rate == 4) {
        reviewsPerRate[3]++;
      } else {
        reviewsPerRate[4]++;
      }
    }

    return reviewsPerRate;
  }

  static double calcAvgRate(List<Review> reviews)
  {
    double sum = 0;

    for (var review in reviews) {
      sum += review.rate;  
    }

    return reviews.isEmpty ? 0 : sum / reviews.length;
  }

   static String? validateTitle(String? title)
  {
    if (title == null || title.isEmpty || title.trim().length < 2)
    {
      return "enter a valid Title";
    }

    return null;
  }  
}
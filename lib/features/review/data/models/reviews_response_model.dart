import 'package:laza_ecommerce/features/review/data/models/review_model.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/reviews_response_entity.dart';

class ReviewsResponseModel extends ReviewsResponseEntity {
  const ReviewsResponseModel({
    super.averageRating,
    super.reviewsCount,
    required super.reviews,
  });

  factory ReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> reviewItems =
        (json['reviews'] != null && json['reviews']['items'] is List)
        ? json['reviews']['items']
        : [];

    return ReviewsResponseModel(
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      reviews: reviewItems.map((item) => ReviewModel.fromJson(item)).toList(),
    );
  }
}

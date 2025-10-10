import 'package:laza_ecommerce/features/review/domain/enteties/review_entity.dart';

class ReviewsResponseEntity {
  final double? averageRating;
  final int? reviewsCount;
  final List<ReviewEntity> reviews;

  const ReviewsResponseEntity({
    this.averageRating,
    this.reviewsCount,
    required this.reviews,
  });
}

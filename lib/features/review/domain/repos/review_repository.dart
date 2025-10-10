// in domain/repositories/review_repository.dart

import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/reviews_response_entity.dart';

abstract class ReviewRepository {
  Future<Either<Failure, ReviewsResponseEntity>> getReviews(String productId);
}

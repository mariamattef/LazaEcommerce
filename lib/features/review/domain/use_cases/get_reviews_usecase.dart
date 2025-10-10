// in domain/usecases/get_reviews_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/reviews_response_entity.dart';
import 'package:laza_ecommerce/features/review/domain/repos/review_repository.dart';

class GetReviewsUseCase {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  Future<Either<Failure, ReviewsResponseEntity>> call(String productId) async {
    return await repository.getReviews(productId);
  }
}

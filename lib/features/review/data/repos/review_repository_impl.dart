import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/review/data/data_source/review_remote_data_source.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/reviews_response_entity.dart';
import 'package:laza_ecommerce/features/review/domain/repos/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ReviewsResponseEntity>> getReviews(
      String productId) async {
    try {
      final reviews = await remoteDataSource.getReviews(productId);
      return Right(reviews);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'An unknown error occurred'));
    }
  }
}
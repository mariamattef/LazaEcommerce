// in data/datasources/review_remote_data_source.dart

import 'package:dio/dio.dart';
import 'package:laza_ecommerce/core/databases/api/end_points.dart';
import 'package:laza_ecommerce/features/review/data/models/reviews_response_model.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewsResponseModel> getReviews(String productId);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl({required this.dio});

  @override
  Future<ReviewsResponseModel> getReviews(String productId) async {
    final response = await dio.get(
      '${EndPoints.baserUrl}${EndPoints.getReviews.replaceFirst('{productId}', productId)}',
    );

    return ReviewsResponseModel.fromJson(response.data);
  }
}

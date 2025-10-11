import 'package:laza_ecommerce/core/databases/api/api_consumer.dart';
import 'package:laza_ecommerce/core/databases/api/end_points.dart';
import 'package:laza_ecommerce/core/errors/error_model.dart';
import 'package:laza_ecommerce/core/errors/exceptions.dart';
import 'package:laza_ecommerce/features/home/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  ApiConsumer api;
  CategoryRemoteDataSourceImpl(this.api);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await api.get(EndPoints.getCategories);
      print('categories response: $response');
      if (response != null && response['categories'] is List) {
        final List<dynamic> data = response['categories'];
        final categories = data.map((json) => CategoryModel.fromJson(json)).toList();
        return categories;
      } else {
        throw ServerException(ErrorModel(status: 400, errorMessage: 'categories key is missing or not a list'));
      }
    } on UnauthorizedException {
      throw ServerException(ErrorModel(status: 401, errorMessage: 'Unauthorized: Please add your token to the ApiInterceptor'));
    } catch (e) {
      throw ServerException(ErrorModel(status: 500, errorMessage: e.toString()));
    }
  }
}

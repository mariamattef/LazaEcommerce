import 'package:dio/dio.dart';
import 'package:laza_ecommerce/core/databases/api/api_consumer.dart';
import 'package:laza_ecommerce/core/databases/api/end_points.dart';
import 'package:laza_ecommerce/core/errors/error_model.dart';
import 'package:laza_ecommerce/core/errors/expentions.dart';
import 'package:laza_ecommerce/core/params/params.dart';
import 'package:laza_ecommerce/features/home/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(ProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ApiConsumer api;
  ProductRemoteDataSourceImpl(this.api);

  @override
  Future<List<ProductModel>> getProducts(ProductParams params) async {
    try {
      final response = await api.get(
        EndPoints.getProducts,
        queryParameters: {'id': params.id},
      );
      final List<dynamic> data = response['items'];
      final products = data.map((json) => ProductModel.fromJson(json)).toList();
      return products;
    } on DioException catch (e) {
      throw ServerException(ErrorModel.fromJson(e.response?.data));
    }
  }
}

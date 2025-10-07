import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/core/params/params.dart';
import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/product_repository.dart';

class ProductUsecase {
  final ProductRepository _productRepository;

  ProductUsecase(this._productRepository);

  Future<Either<Failure, List<ProductEntity>>> call({
    required ProductParams params,
  }) async {
    return await _productRepository.getProducts(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/connection/network_info.dart';
import 'package:laza_ecommerce/core/errors/exceptions.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/core/params/params.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final InternetService internetService;
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({
    required this.internetService,
    required this.productRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    ProductParams params,
  ) async {
    if (await internetService.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource.getProducts(
          params,
        );
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorModel.errorMessage));
      }
    } else {
      return Left(ServerFailure('No internet connection'));
    }
  }
}

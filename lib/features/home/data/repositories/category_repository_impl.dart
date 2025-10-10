import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/connection/network_info.dart';
import 'package:laza_ecommerce/core/errors/expentions.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final InternetService internetService;
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({
    required this.internetService,
    required this.categoryRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await internetService.isConnected) {
      try {
        final remoteCategory = await categoryRemoteDataSource.getCategories();
        print('remoteCategory is >>>>>>>>$remoteCategory');
        return Right(remoteCategory);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorModel.errorMessage));
      }
    } else {
      return Left(ServerFailure('No internet connection'));
    }
  }
}

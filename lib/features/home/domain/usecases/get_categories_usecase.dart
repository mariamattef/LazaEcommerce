
import 'package:dartz/dartz.dart';
import 'package:laza_ecommerce/core/errors/failure.dart';
import 'package:laza_ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;

  GetCategoriesUseCase(this.categoryRepository);

  Future<Either<Failure, List<CategoryEntity>>>call() async {
    return await categoryRepository.getCategories();
  }
}

import 'package:laza_ecommerce/features/home/domain/entities/category_entity.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class GetCategoryLoading extends CategoryState {}

class GetCategorySuccess extends CategoryState {
  final List<CategoryEntity> categories;

  const GetCategorySuccess(this.categories);
}

class GetCategoryFailure extends CategoryState {
  final String message;

  const GetCategoryFailure(this.message);
}

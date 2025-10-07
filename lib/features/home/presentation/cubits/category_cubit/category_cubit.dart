import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryCubit(this.getCategoriesUseCase) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(GetCategoryLoading());
    final result = await getCategoriesUseCase();
    result.fold(
      (failure) => emit(GetCategoryFailure(failure.errMessage)),
      (categories) => emit(GetCategorySuccess(categories)),
    );
  }
}

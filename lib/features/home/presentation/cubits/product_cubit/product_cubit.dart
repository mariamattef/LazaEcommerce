import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce/core/params/params.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/product_usecase.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductUsecase productUsecase;

  ProductCubit(this.productUsecase) : super(ProductInitial());

  Future<void> getProducts(String id) async {
    emit(ProductLoading());
    final result = await productUsecase.call(params: ProductParams(id: id));
    result.fold(
      (failure) => emit(ProductFailure(failure.errMessage)),
      (products) => emit(Productsuccess(products)),
    );
  }
}

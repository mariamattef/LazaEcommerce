import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class Productsuccess extends ProductState {
  final List<ProductEntity> products;
  Productsuccess(this.products);
}

class ProductFailure extends ProductState {
  final String message;
  ProductFailure(this.message);
}

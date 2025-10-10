import 'package:equatable/equatable.dart';
import 'package:laza_ecommerce/features/home/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String sellerId;
  final CategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
     this.imageUrl ,
    required this.sellerId,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    imageUrl,
    sellerId,
    category,
  ];
}

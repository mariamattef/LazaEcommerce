import 'package:laza_ecommerce/features/home/data/models/category_model.dart';
import 'package:laza_ecommerce/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final String? productCode;
  final String? arabicName;
  final String? arabicDescription;
  final String? imgUrl;
  final dynamic productPictures;
  final int? stock;
  final double? weight;
  final String? color;
  final int? rating;
  final int? reviewsCount;
  final int? discountPercentage;
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.sellerId,
    required super.category,
    this.productCode,
    this.arabicName,
    this.arabicDescription,
    this.imgUrl,
    this.productPictures,
    this.stock,
    this.weight,
    this.color,
    this.rating,
    this.reviewsCount,
    this.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: (json['coverPictureUrl'] as String)
          .replaceAll('0files', '0/files')
          .replaceAll('1files', '1/files')
          .replaceAll('2files', '2/files')
          .replaceAll('3files', '3/files')
          .replaceAll('4files', '4/files')
          .replaceAll('5files', '5/files')
          .replaceAll('6files', '6/files')
          .replaceAll('7files', '7/files')
          .replaceAll('8files', '8/files')
          .replaceAll('9files', '9/files'),
      sellerId: json['sellerId'],
      category: (json['categories'] != null &&
              json['categories'] is List &&
              json['categories'].isNotEmpty)
          ? (json['categories'][0] is Map<String, dynamic>
              ? CategoryModel.fromJson(json['categories'][0])
              : CategoryModel(
                  id: json['categories'][0].toString(),
                  name: '',
                  description: '',
                  coverPictureUrl: ''))
          : const CategoryModel(
              id: '', name: '', description: '', coverPictureUrl: ''),
      productCode: json['productCode'],
      arabicName: json['arabicName'] as String?,
      arabicDescription: json['arabicDescription'] as String?,
      imgUrl: json['coverPictureUrl'] as String?,
      productPictures: json['productPictures'] as dynamic,
      stock: (json['stock'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      color: json['color'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      discountPercentage: (json['discountPercentage'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'coverPictureUrl': imageUrl,
      'sellerId': sellerId,
      'category': (category as CategoryModel).toJson(),
      'productCode': productCode,
      'arabicName': arabicName,
      'arabicDescription': arabicDescription,
      'productPictures': productPictures,
      'stock': stock,
      'weight': weight,
      'color': color,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
    };
  }
}

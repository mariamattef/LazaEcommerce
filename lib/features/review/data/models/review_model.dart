// in data/models/review_model.dart

import 'package:laza_ecommerce/features/review/domain/enteties/review_entity.dart'
    show ReviewEntity;

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required String super.userName,
    required String super.comment,
    required double super.rating,
    required String super.createdAt,
    super.userPicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'] ?? 'Unknown User',
      comment: json['comment'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] ?? '',
      userPicture: json['userPicture'],
    );
  }
}

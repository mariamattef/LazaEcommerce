// in domain/entities/review_entity.dart

import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String? userName;
  final String? comment;
  final double? rating;
  final String? createdAt;
  final String? userPicture;

  const ReviewEntity({
    required this.userName,
    required this.comment,
    required this.rating,
    required this.createdAt,
    this.userPicture,
  });

  @override
  List<Object?> get props => [
    userName,
    comment,
    rating,
    createdAt,
    userPicture,
  ];
}

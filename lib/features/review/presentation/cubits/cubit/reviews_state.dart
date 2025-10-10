// in presentation/cubit/reviews_state.dart

import 'package:equatable/equatable.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/reviews_response_entity.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final ReviewsResponseEntity reviewsResponse;

  const ReviewsLoaded(this.reviewsResponse);

  @override
  List<Object?> get props => [reviewsResponse];
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError(this.message);

  @override
  List<Object?> get props => [message];
}
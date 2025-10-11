// in presentation/cubit/reviews_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce/features/review/domain/use_cases/get_reviews_usecase.dart';

import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetReviewsUseCase getReviewsUseCase;

  ReviewsCubit({required this.getReviewsUseCase}) : super(ReviewsInitial());

  Future<void> fetchReviews(String productId) async {
    emit(ReviewsLoading());
    try {
      final reviews = await getReviewsUseCase(productId);
      reviews.fold(
        (failure) => emit(ReviewsError('Failed to fetch reviews')),
        (reviews) => emit(ReviewsLoaded(reviews)),
      );
    } catch (e) {
      emit(ReviewsError('Failed to fetch reviews: ${e.toString()}'));
    }
    final result = await getReviewsUseCase(productId);

    result.fold(
      (failure) {
        emit(ReviewsError('Failed to fetch reviews: ${failure.errorMessage}'));
      },
      (reviewsResponse) {
        emit(ReviewsLoaded(reviewsResponse));
      },
    );
  }
}

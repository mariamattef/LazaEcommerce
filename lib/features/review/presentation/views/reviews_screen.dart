import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/features/home/presentation/widgets/reviews_item.dart';
import 'package:laza_ecommerce/features/review/domain/enteties/review_entity.dart';
import 'package:laza_ecommerce/features/review/presentation/cubits/cubit/reviews_cubit.dart';
import 'package:laza_ecommerce/features/review/presentation/cubits/cubit/reviews_state.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;
  const ReviewsScreen({super.key, required this.productId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewsCubit>().fetchReviews(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewsLoaded) {
            print(state.reviewsResponse.reviews);
            if (state.reviewsResponse.reviews.isEmpty) {
              final random = Random();
              int randomNumber = random.nextInt(99);

              return Padding(
                padding: EdgeInsets.all(25.0.r),
                child: ReviewsItem(
                  backgroundImage:
                      'https://randomuser.me/api/portraits/men/$randomNumber.jpg',
                  name: 'Ronald Richards',
                  rating: '4.8 rating',
                  date: '13 Sep, 2020',
                  comment:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...',
                ),
              );
            }
            return ListView.builder(
              itemCount: state.reviewsResponse.reviews.length,
              itemBuilder: (context, index) {
                final review = state.reviewsResponse.reviews[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.r,
                    vertical: 8.0.r,
                  ),
                  child: _buildReviewItem(review),
                );
              },
            );
          } else if (state is ReviewsError) {
            return Center(child: Text(state.message));
          }
          return const Center(
            child: Text('No reviews yet.'),
          ); // Fallback for initial state or unexpected state
        },
      ),
    );
  }

  Widget _buildReviewItem(ReviewEntity review) {
    return ReviewsItem(
      backgroundImage:
          review.userPicture ??
          'https://i.pravatar.cc/150?u=${review.userName}', // Fallback image
      name: review.userName ?? 'Anonymous',
      rating: '${review.rating?.toStringAsFixed(1) ?? '0.0'} rating',
      date: review.createdAt?.substring(0, 10) ?? '', // Basic date formatting
      comment: review.comment ?? 'No comment provided.',
    );
  }
}

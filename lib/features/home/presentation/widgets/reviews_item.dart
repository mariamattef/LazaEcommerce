import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsItem extends StatelessWidget {
  final String backgroundImage;
  final String name;
  final String rating;
  final String date;
  final String comment;
  const ReviewsItem({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(backgroundImage),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(rating),
                      RatingBar.builder(
                        initialRating: 4.8,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 14,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(date, style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(comment, style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}

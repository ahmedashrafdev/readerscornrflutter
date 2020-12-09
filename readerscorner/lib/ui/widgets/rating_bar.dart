import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingBar(double initialRating) {
  return RatingBarIndicator(
          rating: initialRating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          itemCount: 5,
          itemSize: 15.0,
          unratedColor: Colors.black.withAlpha(50),
          direction:  Axis.horizontal,
        );
  
}
  
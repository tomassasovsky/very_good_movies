import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_client/movies_client.dart';

class PosterAndTitle extends StatelessWidget {
  const PosterAndTitle(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.dw,
      margin: EdgeInsets.symmetric(vertical: 20.sp),
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: movie.id ?? movie,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.posterFullPath),
                height: 150.sp,
              ),
            ),
          ),
          SizedBox(width: 20.sp),
          SizedBox(
            height: 150.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      movie.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      movie.originalTitle ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                RatingBar.builder(
                  initialRating: (movie.voteAverage ?? 1) / 2,
                  allowHalfRating: true,
                  itemSize: 25.sp,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

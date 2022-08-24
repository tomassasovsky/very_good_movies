import 'package:appsize/appsize.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_client/movies_client.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper(
    this.movies, {
    super.key,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 50.dh,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 50.dh,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: 60.dw,
        itemHeight: 40.dh,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {},
            child: Hero(
              tag: index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'assets/no-image.jpg',
                  ),
                  image: NetworkImage(movie.posterFullPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

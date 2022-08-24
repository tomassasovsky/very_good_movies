import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:movies_client/movies_client.dart';
import 'package:paginated_list/paginated_list.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
    this.movies, {
    super.key,
  });

  final List<Movie> movies;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230.sp,
      child: PaginatedList<Movie>(
        items: widget.movies,
        onLoadMore: (index) {},
        isLastPage: false,
        scrollDirection: Axis.horizontal,
        builder: (item, index) => MoviePoster(
          movie: item,
          heroId: index,
        ),
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.movie,
    required this.heroId,
  });

  final Movie movie;
  final int heroId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.sp,
      height: 230.sp,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: movie,
            ),
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'assets/no-image.jpg',
                  ),
                  image: NetworkImage(movie.posterFullPath),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.sp),
          Text(
            movie.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

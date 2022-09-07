import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_client/movies_client.dart';
import 'package:paginated_list/paginated_list.dart';
import 'package:very_good_movies/details/view/details_page.dart';
import 'package:very_good_movies/home/cubit/home_cubit.dart';
import 'package:very_good_movies/home/widgets/widgets.dart';

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
        onLoadMore: (index) => context.read<HomeCubit>().getMorePopularMovies(),
        loadingIndicator: const PaginateLoadingMoreIndicator(),
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
            onTap: () => context.pushNamed(
              PageDetails.name,
              extra: <String, Movie>{
                'movie': movie,
              },
            ),
            child: Hero(
              tag: '${movie.id}-${movie.posterPath}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'assets/no-image.jpg',
                  ),
                  image: NetworkImage(movie.posterFullPath),
                  width: 130.sp,
                  height: 190.sp,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.sp),
          Text(
            movie.title ?? '',
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

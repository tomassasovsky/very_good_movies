import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_client/movies_client.dart';
import 'package:paginated_list/paginated_list.dart';
import 'package:very_good_movies/details/view/details_page.dart';
import 'package:very_good_movies/home/search_cubit/search_cubit.dart';
import 'package:very_good_movies/home/widgets/widgets.dart';
import 'package:very_good_movies/l10n/l10n.dart';

class MovieSearchDelegate extends SearchDelegate<dynamic> {
  MovieSearchDelegate(this.label);

  final String label;

  @override
  String get searchFieldLabel => label;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return EmptySearchMovie(title: context.l10n.searchMovie);
    }

    final searchCubit = context.read<SearchCubit>()..searchMovies(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.isAttempting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else if (state.isEmpty) {
          return EmptySearchMovie(title: context.l10n.noSuggests);
        } else if (state is SearchSuccess) {
          return PaginatedList<Movie>(
            builder: (item, index) => MovieItem(item),
            onLoadMore: (_) => searchCubit.searchMoreMovies(query),
            items: state.movies,
            isLastPage: state.isLastPage,
            loadingIndicator: const PaginateLoadingMoreIndicator(),
          );
        } else if (state.isFailure) {
          return Center(
            child: Builder(
              builder: (context) {
                if (state.isInternetFailure) {
                  return HomeError(
                    icon: Icons.wifi_off,
                    message: context.l10n.internetFailure,
                  );
                } else if (state.isTypeFailure) {
                  return HomeError(
                    icon: Icons.error_outline,
                    message: context.l10n.typeFailure,
                  );
                }
                return HomeError(
                  icon: Icons.warning,
                  message: context.l10n.unknownFailure,
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'search-delegate-${movie.id}',
        child: Image.network(
          movie.posterFullPath,
          width: 50.sp,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title ?? ''),
      subtitle: Text(movie.originalTitle ?? ''),
      onTap: () => context.pushNamed(
        PageDetails.name,
        extra: <String, Movie>{
          'movie': movie,
        },
      ),
    );
  }
}

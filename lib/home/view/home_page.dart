import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:very_good_movies/home/cubit/home_cubit.dart';
import 'package:very_good_movies/home/view/search_delegate.dart';
import 'package:very_good_movies/home/widgets/widgets.dart';
import 'package:very_good_movies/l10n/l10n.dart';
import 'package:very_good_movies/settings/view/settings_page.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        moviesClient: context.read<MoviesClient>(),
        moviesRepository: context.read<MoviesRepository>(),
      ),
      child: const ViewHome(),
    );
  }
}

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.home),
            elevation: 4,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search_outlined,
                  size: 24.sp,
                ),
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(context.l10n.searchMovie),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 24.sp,
                ),
                onPressed: () {
                  if (state is HomeSuccess) {
                    context.pushNamed(
                      ViewSettings.name,
                      extra: {
                        'languages': state.languages,
                      },
                    );
                  }
                },
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state is HomeSuccess) {
                return RefreshIndicator(
                  onRefresh: context.read<HomeCubit>().init,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: ListView(
                    children: [
                      CardSwiper(state.nowPlayingMovies),
                      MovieSlider(state.popularMovies),
                    ],
                  ),
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
              } else if (state is HomeAttempting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

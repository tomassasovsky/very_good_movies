import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:very_good_movies/home/cubit/home_cubit.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
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
    context.read<HomeCubit>().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {}, // => showSearch(context: context, delegate: delegate),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return const Center(
              child: Text('Success'),
            );
          } else if (state is HomeFailure) {
            return const Center(
              child: Text('Failure'),
            );
          } else if (state is HomeAttempting) {
            return const Center(
              child: Text('Attempting'),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

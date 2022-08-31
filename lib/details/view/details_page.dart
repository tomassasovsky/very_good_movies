import 'package:credits_repository/credits_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_client/movies_client.dart';
import 'package:very_good_movies/details/cubit/details_cubit.dart';
import 'package:very_good_movies/details/widgets/widgets.dart';

class PageDetails extends StatelessWidget {
  const PageDetails(
    this.movie, {
    super.key,
  });

  static const name = 'details';

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(
        creditsRepository: context.read<CreditsRepository>(),
      ),
      child: ViewDetails(movie),
    );
  }
}

class ViewDetails extends StatefulWidget {
  const ViewDetails(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsCubit>().getCredits(1, widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state.isAttempting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isFailure) {
            return const Center(
              child: Text('ERROR GIL'),
            );
          } else if (state is DetailsSuccess) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                CustomAppBar(widget.movie),
                SliverList(
                  delegate: SliverChildListDelegate([
                    PosterAndTitle(widget.movie),
                    Overview(widget.movie),
                    Overview(widget.movie),
                    Overview(widget.movie),
                    CastingCards(state.credits),
                  ]),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

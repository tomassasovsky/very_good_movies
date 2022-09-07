// ignore_for_file: lines_longer_than_80_chars

import 'package:appsize/appsize.dart';
import 'package:credits_repository/credits_repository.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:very_good_movies/details/view/details_page.dart';
import 'package:very_good_movies/home/home.dart';
import 'package:very_good_movies/home/search_cubit/search_cubit.dart';
import 'package:very_good_movies/l10n/l10n.dart';
import 'package:very_good_movies/settings/cubit/settings_cubit.dart';
import 'package:very_good_movies/settings/models/movie_theme.dart';
import 'package:very_good_movies/settings/view/settings_page.dart';

class PageApp extends StatelessWidget {
  const PageApp({
    super.key,
    required this.dataPersistenceRepository,
  });

  final DataPersistenceRepository dataPersistenceRepository;

  @override
  Widget build(BuildContext context) {
    final language = dataPersistenceRepository.language ?? 'en_US';

    final moviesClient = MoviesClient(
      apiKey: dotenv.env['API_KEY'] ?? '',
      language: language,
    );

    final moviesRepository = MoviesRepository(moviesClient);
    final creditsRepository = CreditsRepository(moviesClient);

    final isDarkMode = dataPersistenceRepository.isDarkMode ?? true;

    if (!isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.grey.shade700,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        ),
      );
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: moviesClient),
        RepositoryProvider.value(value: dataPersistenceRepository),
        RepositoryProvider.value(value: moviesRepository),
        RepositoryProvider.value(value: creditsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SearchCubit(moviesRepository: moviesRepository),
          ),
          BlocProvider(
            create: (_) => SettingsCubit(
              language: language,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              dataPersistenceRepository: dataPersistenceRepository,
              creditsRepository: creditsRepository,
              moviesRepository: moviesRepository,
            ),
          ),
        ],
        child: AppSize.child(
          child: const App(),
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = router();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText1!,
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
        themeMode: context.watch<SettingsCubit>().state.themeMode,
        theme: MovieTheme.lightTheme,
        darkTheme: MovieTheme.darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  GoRouter router() {
    return GoRouter(
      errorBuilder: (context, state) => RoutingErrorPage(state.path),
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: PageHome.name,
          builder: (context, state) => const PageHome(),
        ),
        GoRoute(
          path: '/details',
          name: PageDetails.name,
          builder: (context, state) {
            final movie = (state.extra as Map?)?['movie'] as Movie?;
            if (movie == null) {
              throw ArgumentError.notNull('movie');
            }
            return PageDetails(movie);
          },
        ),
        GoRoute(
          path: '/settins',
          name: ViewSettings.name,
          builder: (context, state) {
            final languages = (state.extra as Map?)?['languages'] as List<Language>?;
            if (languages == null) {
              throw ArgumentError.notNull('movie');
            }
            return ViewSettings(
              languages: languages,
            );
          },
        ),
      ],
    );
  }
}

class RoutingErrorPage extends StatelessWidget {
  const RoutingErrorPage(this.path, {super.key});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final phrase = context.l10n.noRoutesForLocation(
      path ?? context.l10n.unknownPath,
    );

    return Scaffold(
      body: Center(
        child: Text(
          phrase,
        ),
      ),
    );
  }
}

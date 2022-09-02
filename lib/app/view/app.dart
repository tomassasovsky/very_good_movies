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

class PageApp extends StatelessWidget {
  const PageApp({
    super.key,
    required this.dataPersistenceRepository,
  });

  final DataPersistenceRepository dataPersistenceRepository;

  @override
  Widget build(BuildContext context) {
    final moviesClient = MoviesClient(
      apiKey: dotenv.env['API_KEY'] ?? '',
      language: dataPersistenceRepository.language ?? 'en_US',
    );

    final moviesRepository = MoviesRepository(moviesClient);
    final creditsRepository = CreditsRepository(moviesClient);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: moviesClient),
        RepositoryProvider.value(value: dataPersistenceRepository),
        RepositoryProvider.value(value: moviesRepository),
        RepositoryProvider.value(value: creditsRepository),
      ],
      child: BlocProvider(
        create: (_) => SearchCubit(moviesRepository: moviesRepository),
        child: const App(),
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black87),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => AppSize(
        builder: (context, orientation, deviceType) => child!,
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

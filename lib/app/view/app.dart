import 'package:credits_repository/credits_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:very_good_movies/counter/counter.dart';
import 'package:very_good_movies/l10n/l10n.dart';

class PageApp extends StatelessWidget {
  const PageApp({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesClient = MoviesClient(
      apiKey: dotenv.env['API_KEY'] ?? '',
      language: 'en-US',
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: moviesClient),
        RepositoryProvider.value(value: MoviesRepository(moviesClient)),
        RepositoryProvider.value(value: CreditsRepository(moviesClient)),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}

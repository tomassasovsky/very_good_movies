import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:very_good_movies/app/app.dart';
import 'package:very_good_movies/bootstrap.dart';

void main() async {
  await dotenv.load();
  await bootstrap(() => const App());
}

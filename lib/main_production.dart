import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:very_good_movies/app/app.dart';
import 'package:very_good_movies/bootstrap.dart';

void main() async {
  await dotenv.load();
  const dataPersistenceRepository = DataPersistenceRepository();
  await dataPersistenceRepository.init();
  await bootstrap(
    () => const PageApp(
      dataPersistenceRepository: dataPersistenceRepository,
    ),
  );
}

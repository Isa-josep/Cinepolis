
import 'package:cinepolis/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinepolis/infrastructure/repositories/actor_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});

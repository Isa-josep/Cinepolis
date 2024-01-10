import 'package:cinepolis/infrastructure/datasources/moviedb_datasoruce.dart';
import 'package:cinepolis/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//Solo lectura y inmutable
final movieRepositoryProvider = Provider((ref) {
  
  return MovieRepositoryImpl(MoviedbDatasource());
});
import 'package:cinepolis/domain/datasources/actor_datasource.dart';
import 'package:cinepolis/domain/entities/actor.dart';
import 'package:cinepolis/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{

  final ActorDataSource dataSource;
  ActorRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return  dataSource.getActorsByMovieId(movieId);
  }
}
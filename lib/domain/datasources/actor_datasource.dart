import 'package:cinepolis/domain/entities/actor.dart';

abstract class ActorDataSource{
 Future<List<Actor>> getActorsByMovieId(String movieId);
 
}
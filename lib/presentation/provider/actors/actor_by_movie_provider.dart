import 'package:cinepolis/domain/entities/actor.dart';
import 'package:cinepolis/presentation/provider/actors/actor_repositoru_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,Map<String,List<Actor>>>((ref) {
  final actorsRepository =ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovieId);
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>>{
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors
    }) : super({});

  Future<void> loadActors(String movieId) async{
    if(state[movieId]!=null) return;
    final List<Actor> actor=await getActors(movieId);
    state={
      ...state, movieId:actor
    };
  }
}
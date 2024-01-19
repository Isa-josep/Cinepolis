import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/provider/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref) {
  final moviesRepository =ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: moviesRepository.getMovieById);
});

typedef GetMovieCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{
  final GetMovieCallBack getMovie;
  MovieMapNotifier({
    required this.getMovie
    }) : super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId]!=null) return;
    final movie=await getMovie(movieId);
    state={
      ...state, movieId:movie
    };
  }
}
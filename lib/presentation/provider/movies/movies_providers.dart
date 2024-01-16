import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/provider/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//peliculas que estane en cartelera
final nowPlayingMovisProvider= StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
  final fetchMoreMovies=ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final popularMoviesProvider= StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
  final fetchMoreMovies=ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final upcomigMoviesProvider= StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
  final fetchMoreMovies=ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final topratingMoviesProvider= StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
  final fetchMoreMovies=ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<Movie>> Function({int page});
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage=0;
  bool isLoading=false;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies,
  }):super([]);

  Future <void>  loadNexPage() async{
    if(isLoading) return;
    isLoading=true;

    currentPage++;
    final List<Movie> movies=await fetchMoreMovies(page: currentPage);
    state=[...state,...movies];
    await Future.delayed(const Duration(milliseconds:300)); //espera antes de que se cargue la siguiente pagina
    isLoading=false;
  } 
}
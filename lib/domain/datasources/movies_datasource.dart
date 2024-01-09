
import 'package:cinepolis/domain/entities/movie.dart';

abstract class MoviesDataSource{
 Future<List<Movie>> getNowPlaying({int pague =1});

}
 
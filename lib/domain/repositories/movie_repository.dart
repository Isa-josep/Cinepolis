
import 'package:cinepolis/domain/entities/movie.dart';

abstract class MovieRepository{
 Future<List<Movie>> getNowPlaying({int pague =1});

}
 
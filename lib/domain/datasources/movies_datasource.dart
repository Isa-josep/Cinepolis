
import 'package:cinepolis/domain/entities/movie.dart';

abstract class MovieDataSource{
 Future<List<Movie>> getNowPlaying({int pague =1});

}
 
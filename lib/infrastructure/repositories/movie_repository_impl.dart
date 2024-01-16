import 'package:cinepolis/domain/datasources/movies_datasource.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
  
  final MoviesDataSource dataSource;
  MovieRepositoryImpl( this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return dataSource.getUpcoming(page: page);
  }

}
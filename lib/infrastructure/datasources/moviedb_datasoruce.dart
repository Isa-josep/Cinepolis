import 'package:cinepolis/config/constants/environment.dart';
import 'package:cinepolis/domain/datasources/movies_datasource.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/infrastructure/mappers/movie_mapper.dart';
import 'package:cinepolis/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';


class MoviedbDatasource extends MoviesDataSource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key':  Environment.moviDdKey,
      'language': 'es-MX',
    }
  ));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing',
    queryParameters: {
      'page': page
    }
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies= movieDBResponse.results
    .where((moviedb) =>moviedb.posterPath != "No-poster")
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
      ).toList();

    return movies;
  }
}
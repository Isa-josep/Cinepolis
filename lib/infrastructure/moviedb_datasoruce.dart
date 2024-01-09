import 'package:cinepolis/config/constants/environment.dart';
import 'package:cinepolis/domain/datasources/movies_datasource.dart';
import 'package:cinepolis/domain/entities/movie.dart';
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
  Future<List<Movie>> getNowPlaying({int pague = 1}) async {
    
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies=[];

    return movies;
  }
}
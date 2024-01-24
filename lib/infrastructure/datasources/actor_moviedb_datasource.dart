import 'package:cinepolis/config/constants/environment.dart';
import 'package:cinepolis/domain/datasources/actor_datasource.dart';
import 'package:cinepolis/domain/entities/actor.dart';
import 'package:cinepolis/infrastructure/mappers/actor_mapper.dart';
import 'package:cinepolis/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';


class ActorMovieDbDatasource extends ActorDataSource{
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key':  Environment.moviDdKey,
      'language': 'es-MX',
    }
  ));
  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async{

    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast.map(
      (cast)=>ActorMapper.castToEntity(cast)).toList();

    return actors;
  }

}
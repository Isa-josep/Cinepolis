import 'package:cinepolis/domain/entities/actor.dart';
import 'package:cinepolis/infrastructure/models/moviedb/credits_response.dart';
class ActorMapper{
  static Actor castToEntity(Cast cast)=>
    Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath !=null ? "https://image.tmdb.org/t/p/w500${cast.profilePath}" : "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg",
      character: cast.character,
    );
}
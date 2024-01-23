import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/config/helpers/human_format.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchMoviesCallback=Future<List<Movie>> Function(String query);


class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({
    required this.searchMovies
    });

  @override 
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      // if(query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,  
          child: IconButton(
          onPressed: (){
            query = "";
            }, 
            icon: const Icon(Icons.delete_outline_rounded)
          ),
        )
      
      
    ];  
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: (){
        context.pop();
      }, 
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query), 
      initialData: const [],
      builder: (context,snapshot){
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context,index){
              return _MovieItem(movie: movies[index]);
            }
        );
      }
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({
    required this.movie
    });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size= MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5), 
      child: Row(
        children: [
          SizedBox(
            width: size.width*0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath
              ),
            ),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: size.width*0.7,
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Text(movie.title,style: textStyle.titleMedium),
                (movie.overview.length>100)
                ? Text('${movie.overview.substring(0,100)}...')
                : Text(movie.overview),
                Row(
                  children: [
                    Icon(Icons.star_half_rounded ,color:Colors.amber),
                    const SizedBox(width: 5,),
                    Text(
                      HumanFormats.number(movie.voteAverage,1),
                      style: textStyle.bodyMedium!.copyWith(color:Colors.amber),
                    )
                  ],
                )
               ],
            ),
          )
        ],
      ),
    );
  }
}

/* 

final movie = movies[index];
              return ListTile(

                // leading: FadeInImage(
                //   placeholder: const AssetImage('assets/loading.gif'), 
                //   image: NetworkImage(movie.posterPath),
                //   width: 50,
                //   fit: BoxFit.contain,
                // ),
                
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){
                  context.go('/movie/${movie.id}');
                },);
          },


*/
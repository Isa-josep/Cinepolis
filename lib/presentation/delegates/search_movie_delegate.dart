import 'package:animate_do/animate_do.dart';
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
              final movie = movies[index];
              return ListTile(

                leading: FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){
                  context.go('/movie/${movie.id}');
                },);
          },
        );
      }
    );
  }
}
import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?>{
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
    return const Text("suggestions");
  }

}
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/config/helpers/human_format.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:flutter/material.dart';


typedef SearchMoviesCallback=Future<List<Movie>> Function(String query);


class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies =StreamController.broadcast();
  StreamController<bool> isLoadingStream =StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies 
  }):super(
    
  );

  void clearStreams(){
    debounceMovies.close();
  }

  void _onQueryChanged(String query){
    isLoadingStream.add(true);
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer =Timer(const Duration(milliseconds: 500),() async { //timepo de espera despues de dejar de escribir 
      
      final movies=await searchMovies(query);
      debounceMovies.add(movies);
      initialMovies=movies;
      isLoadingStream.add(false);
      await Future.delayed(const Duration(milliseconds: 500));
    });
  }

  Widget buildResultAndSuggestions(){
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context,snapshot){
        
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context,index){
              return _MovieItem(
                movie: movies[index],
                onMovieSelected: (contex,movie){
                  clearStreams();
                  close(context,movie);
                },
              );
            }
        );
      }
    );  
  }

  @override 
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[

        StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream, 
          builder: (context,snapshot){
            if(snapshot.data ??false){
              return SpinPerfect(
                duration: const Duration(seconds: 20),
                spins: 10,
                infinite: true,
                
                child: IconButton(
                onPressed: (){
                  query = "";
                  }, 
                  icon: const Icon(Icons.refresh)
                ),
              );
            }
              return FadeIn(
                animate: query.isNotEmpty,  
                child: IconButton(
                onPressed: (){
                query = "";
              }, 
              icon: const Icon(Icons.clear_rounded)
            ),
          );
        }
      ),
    ];  
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: ()=>{
        clearStreams(),
        close(context,null)
      } ,
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
    });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size= MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        onMovieSelected(context, movie);
      },
      child: Padding(
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
                      const Icon(Icons.star_half_rounded ,color:Colors.amber),
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
import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie( widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors( widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie =ref.watch(movieInfoProvider)[widget.movieId];
    if(movie==null){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2,)
        )
      );
    }
    return  Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), //BouncingScrollPhysics
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index)=>_MovieDetails(movie: movie),
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({ required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle =Theme.of(context).textTheme;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  width: size.width*0.3,
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: (size.width-40) *0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,style: textStyle.titleLarge),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
            
          ),
        ),

         Padding(padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genreIds.map((gender)=> Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                      side: BorderSide(color: Colors.grey)
                    ),
                  ),
                ))
              ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Actores',style: textStyle.titleLarge,),
        ),
        _ActorByMovie(movieId: movie.id.toString(),),
       const SizedBox(height: 5,),
      ],
    );
  }
}

final  isFavoriteProvider=FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository =ref.watch(localStorageRepositoryProvider);
   
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({ 
    required this.movie
  });

  @override
  Widget build(BuildContext context,ref) {
    final size= MediaQuery.of(context).size;

    final isFavoriteFuture=ref.watch(isFavoriteProvider(movie.id));
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight:size.height*0.7 ,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            ref.watch(localStorageRepositoryProvider).toggleFavorite(movie)
              .then((_) =>
                  //! Reload the favorite info then redraw the favorite icon
              ref.invalidate(isFavoriteProvider(movie.id)),
            );
          },
          // onPressed: (){
          //   //* agregar o quitar de favoritos
          //   ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
          //   ref.invalidate(isFavoriteProvider(movie.id));
          // },
          icon: isFavoriteFuture.when(
            data: (isFavorite)=> isFavorite 
            ? const Icon(Icons.favorite, color:Colors.red)
            : const Icon(Icons.favorite_border),
            error: (_,__)=>throw UnimplementedError(), 
            loading:()=> const CircularProgressIndicator(strokeWidth: 2,)
          )
          //const Icon(Icons.favorite_border),
          //icon: const Icon(Icons.favorite_outlined, color:Colors.red),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress){
                  if(loadingProgress==null) return FadeIn(child: child);
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2,)
                  );
                },
              ),
            ),

            //* Gradiente de arriba hacia abajo para visualizar mejor el ttitulo

            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7,1.0],
              colors: [
                Colors.transparent,
                Colors.black,
              ]
            ),

            //*Gradiante para visualizar el icono de favorito

            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0,0.2],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),

            //* Gradiente de izquierda a derecha para visualizar icono de back

            const _CustomGradient(
              begin: Alignment.topLeft,
              //end: Alignment.topRight,
              stops: [0.0,0.4],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            )
          ],
        ),
      ),
    );
  }
}



class _ActorByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context,ref) {
    final actorsByMovie= ref.watch(actorsByMovieProvider);
    if(actorsByMovie[movieId]==null){
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2,)
      );
    }
    final actors=actorsByMovie[movieId]!;
    return SizedBox(
      height: 320+10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context,index){
          final actor=actors[index];
          return FadeInRight(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 135,
              child: Column(
                children: [
                  ClipRRect(  
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.network(
                      actor.profilePath,
                      height: 210,
                      width: 135,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) return  const CircularProgressIndicator(strokeWidth: 2,);
                        return 
                          //FadeIn(child: child);
                          child;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    actor.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, //crea puntos suspensivos si es que queda mas texto
                  ),
                  Text(
                    actor.character??'Undefine',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, //crea puntos suspensivos si es que queda mas texto
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





/*

background: Stack(
        //   children: [
        //     Positioned.fill(
        //       child: Image.network(
        //         movie.posterPath,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Positioned.fill(
        //       child: Container(
        //         decoration: const BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Colors.black,
        //               Colors.transparent,
        //             ],
        //             begin: Alignment.bottomCenter,
        //             end: Alignment.topCenter,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),




SizedBox.expand(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),


 */


/*
(context,index){
              return Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  movie.overview,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              );
            
            }
 */

class _CustomGradient extends StatelessWidget {
  final Alignment begin;
  final Alignment? end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradient({
   required this.begin, 
   this.end, 
   required this.stops, 
   required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: Alignment.bottomCenter,
            stops: stops,
            colors: [
              colors[0],
              colors[1],
            ],
          )
        ),
      ),
    );
  }
}
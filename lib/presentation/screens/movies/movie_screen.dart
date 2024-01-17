import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/provider/movies/movie_info_provider.dart';
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
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({ 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight:size.height*0.7 ,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  )
                ),
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    //end: Alignment.bottomCenter,
                    stops: [0.0,0.4],
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  )
                ),
              ),
            ),

          ],
        ),
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


TODO Gradiantes 

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


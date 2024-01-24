import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/delegates/search_movie_delegate.dart';
import 'package:cinepolis/presentation/provider/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final colors =Theme.of(context).colorScheme;
    final titleStyles =Theme.of(context).textTheme.titleSmall;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
                Icon(Icons.movie_outlined,color: colors.primary),
                const SizedBox(width: 10),
                Text('Cinepolis',style: titleStyles),

              const Spacer(),
              IconButton (
                onPressed: (){
                  final movieRespository= ref.read(movieRepositoryProvider);
                    showSearch<Movie?> (
                    context: context, 
                    delegate: SearchMovieDelegate(
                    searchMovies: movieRespository.searchMovies
                  )).then((movie){
                    if(movie==null)return;
                    context.push('/movie/${movie.id}');
                    }
                  );
                },
                icon: const Icon(Icons.search),
              ),
              
              // CircleAvatar(
              //   radius: 15,
              //   backgroundColor: Colors.red,
              //   child: const Text('SL'),
              // )
            ],
          ),
        ),
      )
    );
  }
}
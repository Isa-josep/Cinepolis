import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({
    super.key, 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: GestureDetector(
        onTap: ()=> context.push('/home/0/movie/${movie.id} ') ,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(20),
          ),
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
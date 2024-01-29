import 'package:cinepolis/domain/entities/movie.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movie;
  final VoidCallback? loadNextPage;
  const MovieMasonry({
    super.key, 
    required this.movie, 
    this.loadNextPage
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3, 
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movie.length,
        itemBuilder: (context, index){
          if(index ==1){
            return Column(
              children: [
                const SizedBox(height: 40,),
                MoviePosterLink(movie: widget.movie[index]),
              ],
            );
          }
          return MoviePosterLink(movie: widget.movie[index]);
        }
      ),
    );
  }
}
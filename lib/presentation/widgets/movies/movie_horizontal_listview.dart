import 'package:animate_do/animate_do.dart';
import 'package:cinepolis/config/helpers/human_format.dart';
import 'package:cinepolis/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List <Movie>movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subTitle, 
    this.loadNextPage
    });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final  scrollController= ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if(widget.loadNextPage==null) return;

      if( scrollController.position.pixels +200 >=scrollController.position.maxScrollExtent){
        //print("Load nex page");
        widget.loadNextPage!();
      }

    });
    super.initState();
  }

    //eliminar el scroll cuando se destruya el widget

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null || widget.subTitle != null)
          _Title(title: widget.title, subTitle: widget.subTitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              }
            )
          )
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {
  final  Movie movie; 
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStile= Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                 loadingBuilder: (context,child,loadingProgress){
                   if(loadingProgress != null){
                    return  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return FadeIn(child: child);
                 //  return child;
                },
              )
            ),
          ),
          const SizedBox(height: 5,),

          //* Titulo de la pelicula
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,// maximo de lineas que se puede mostrar
              style: textStile.titleSmall, 
            ),
          ),
          //* Raiting de la pelicula
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(Icons.star_half_outlined,color: Colors.amber,),
                const SizedBox(width: 5,),
                Text(movie.voteAverage.toStringAsFixed(1),style: textStile.bodyMedium?.copyWith(color: Colors.amber),),
               // const SizedBox(width: 5,),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity),style: textStile.bodyMedium?.copyWith(color: Colors.grey))
                //Text('${movie.popularity}',style: textStile.bodyMedium?.copyWith(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({ this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {

    final titleStile= Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
          Text(title!, style: titleStile,),
          const Spacer(),
          if(subTitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){}, 
            child:  Text(subTitle!),  //subTitle!
          )
        ],
      ),
    );
  }
}
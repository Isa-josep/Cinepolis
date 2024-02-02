import 'package:cinepolis/presentation/provider/providers.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
   const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {


  bool isLastPague=false;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage()async{
    if(isLoading || isLastPague) return;
    isLoading=true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading=false;
    if(movies.isEmpty){
      isLastPague=true;
    }
    //setState(()=>isLoading=true);
  }

  @override

  Widget build(BuildContext context) {
    final favoriteMovies=ref.watch(favoriteMoviesProvider).values.toList(); 

    if(favoriteMovies.isEmpty){
      final color = Theme.of(context).colorScheme;
      return  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.favorite_border_outlined, size: 100, color: color.primary),
              const SizedBox(height: 20),
              Text(
                'ohhh no!!',
                style: TextStyle(
                  fontSize: 50,
                  color: color.primary,
                ),
              ),
              const Text(
                'No tienes peliculas favoritas',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: (){
                  context.go('/home/0');
                }, 
                child: const Text('Explorar')
              )
            ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: MovieMasonry(
        movie: favoriteMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
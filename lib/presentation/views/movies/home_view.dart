import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cinepolis/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_MX', null).then((_) {
      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
      ref.read(popularMoviesProvider.notifier).loadNexPage();
      ref.read(topratingMoviesProvider.notifier).loadNexPage();
      ref.read(upcomigMoviesProvider.notifier).loadNexPage();
    });
  }
  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading)  return const FullScreenLoader();

    final nowPlayingMovies =ref.watch(nowPlayingMovisProvider);
    //if(nowPlayingMovies.length ==0) return CircularProgressIndicator();
    final pelisCortadas = ref.watch(moviesSlideshowProvider);
    final pupularMovies =ref.watch(popularMoviesProvider);
    final topRatedMovies =ref.watch(topratingMoviesProvider);
    final upcomingMovies =ref.watch(upcomigMoviesProvider);
    String date = DateFormat('EEEE d', 'es_MX').format(DateTime.now());
    
    return CustomScrollView( //para que no se desborde la pantalla agrega scroll tambie  SingleChildScrollView
      slivers: [
        const SliverAppBar(
          title: CustomAppbar(),
          floating: true,
          // flexibleSpace: FlexibleSpaceBar(
          //   title: CustomAppbar(), //* se supone que debe de ir hay, pero se ve feo
          // ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return Column(  
                children: [
                  //const CustomAppbar(),
                  MoviesSlideShow(movies: pelisCortadas),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cartelera',
                    //* implemented function to get the current date
                    subTitle: date.toString(),
                    loadNextPage: (){
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                 //   subTitle: 'Lunes 15',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(upcomigMoviesProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: pupularMovies,
                    title: 'Populares',
                  // subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(popularMoviesProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                  // subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(topratingMoviesProvider.notifier).loadNexPage();
                    },
                  ),
              
                  
                ],
              );
            },
            childCount: 1
        )),
      ]
    );
  }
}
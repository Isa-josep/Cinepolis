import 'package:cinepolis/presentation/provider/providers.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
     bottomNavigationBar:CustomButtomNavigation() ,
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovisProvider.notifier).loadNexPage();

  }
  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies =ref.watch(nowPlayingMovisProvider);
    //if(nowPlayingMovies.length ==0) return CircularProgressIndicator();
    final pelisCortadas = ref.watch(moviesSlideshowProvider);
    
    
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
                    subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'Próximamente',
                    subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'Pupulares',
                  // subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
                    },
                  ),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'Mejor calificadas',
                  // subTitle: 'Jueves 11',//todo: implementar funcion para que sea la fecha actual
                    loadNextPage: (){
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
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
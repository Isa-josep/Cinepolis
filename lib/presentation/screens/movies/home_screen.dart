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
    return Column(
      
      children: [
        const CustomAppbar(),

        MoviesSlideShow(movies: pelisCortadas)

        //   Expanded(
        //     child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context,index){
        //     final movie =nowPlayingMovies[index];
        //     return ListTile(
        //     title: Text(movie.title),
        //       );
        //     }
        //   ),
        // )
      ],
    );
  }
}
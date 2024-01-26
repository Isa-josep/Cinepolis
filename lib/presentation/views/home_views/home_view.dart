import 'package:cinepolis/presentation/provider/providers.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    // Inicializa la información de localización para español de México
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

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMovisProvider);
    final pelisCortadas = ref.watch(moviesSlideshowProvider);
    final pupularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topratingMoviesProvider);
    final upcomingMovies = ref.watch(upcomigMoviesProvider);

    String date = DateFormat('EEEE d', 'es_MX').format(DateTime.now());

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: CustomAppbar(),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideShow(movies: pelisCortadas),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cartelera',
                    subTitle: date.toString(),
                    loadNextPage: () {
                      ref.read(nowPlayingMovisProvider.notifier).loadNexPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    loadNextPage: () {
                      ref.read(upcomigMoviesProvider.notifier).loadNexPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: pupularMovies,
                    title: 'Populares',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNexPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    loadNextPage: () {
                      ref.read(topratingMoviesProvider.notifier).loadNexPage();
                    },
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

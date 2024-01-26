import 'package:cinepolis/presentation/screens/screens.dart';
import 'package:cinepolis/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(chlidView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state){
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'sinId';
                return  MovieScreen(movieId: movieId,);
              },
            )
          ]
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state){
            return const FavoritesViews();
          },
        ),
      ]
    ),


    //! rutas de las vistas
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state)=> const HomeScreen(chlidView: FavoritesViews(),),
    //   routes: [
    //     GoRoute(
    //   path: 'movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'sinId';
    //     return  MovieScreen(movieId: movieId,);
    //   },
    // )
    //   ]
    // ),

    
  ]
);


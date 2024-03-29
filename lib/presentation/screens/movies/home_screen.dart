import 'package:cinepolis/presentation/views/views.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  final int pageIndex;
  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
     bottomNavigationBar:CustomButtomNavigation(currentIndex: pageIndex) ,
    );
  }
}


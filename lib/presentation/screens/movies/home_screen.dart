import 'package:cinepolis/presentation/views/views.dart';
import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoritesView(),
     bottomNavigationBar:CustomButtomNavigation() ,
    );
  }
}


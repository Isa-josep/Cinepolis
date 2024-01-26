import 'package:cinepolis/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home_screen';

  final Widget chlidView;

  const HomeScreen({super.key, required this.chlidView});

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: chlidView,
     bottomNavigationBar:const CustomButtomNavigation() ,
    );
  }
}


import 'package:flutter/material.dart';

class CustomButtomNavigation extends StatelessWidget {
  const CustomButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,// elevacion o pronunciasion de la barra
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline),
          label: 'Próximamente'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoritos'
        ),
      ],
    );
  }
}
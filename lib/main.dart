import 'package:flutter/material.dart';
import 'package:cinepolis/config/router/app_router.dart';
import 'package:cinepolis/config/themes/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(), // usar el tema que esta definido el el app theme 
      
    );
  }
}

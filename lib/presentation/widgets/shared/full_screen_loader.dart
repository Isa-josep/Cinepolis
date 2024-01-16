import 'package:flutter/material.dart';
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  

  Stream<String> getLoadingMessages(){
    final messages=<String>[
    'Cargando peliculas',
    'Cargando populares',
    'Cargando top rated',
    'Cargando proximamente',
    'Un momento',
    'Casi listo',
    'Esto esta tardando mas de lo esperado :('
  ];
    return Stream.periodic(const Duration(milliseconds: 700),(step){
      return messages[step ]; //% messages.length
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Please wait..."),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("CArgando...");
              return Text(snapshot.data!);
            }
          )
        ],
      ),
    );
  }
}
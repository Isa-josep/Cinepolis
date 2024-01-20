import 'package:cinepolis/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors =Theme.of(context).colorScheme;
    final titleStyles =Theme.of(context).textTheme.titleSmall;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
                Icon(Icons.movie_outlined,color: colors.primary),
                const SizedBox(width: 10),
                Text('Cinepolis',style: titleStyles),

              const Spacer(),
              IconButton(
                onPressed: (){
                  showSearch(context: context, 
                  delegate: SearchMovieDelegate()
                  );
                },
                icon: const Icon(Icons.search),
              ),
              
              // CircleAvatar(
              //   radius: 15,
              //   backgroundColor: Colors.red,
              //   child: const Text('SL'),
              // )
            ],
          ),
        ),
      )
    );
  }
}
import 'package:app_movies/ui/providers/movies_provider.dart';
import 'package:app_movies/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                      context: context,
                      delegate: MovieSearchDelegate(),
                    ),
                icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Tarjetas principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares', //opcional
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}

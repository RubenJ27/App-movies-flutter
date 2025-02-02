import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/movies_bloc.dart';
import '../../widgets/card_swiper.dart';
import '../../widgets/movie_slider.dart';
import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc.add(GetOnDisplayMovies());
    moviesBloc.add(GetPopularMovies());

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
            BlocListener<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is DisplayMoviesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error Movies: ${state.errorMessage}')),
                  );
                }
              },
              child: Column(
                children: [
                  BlocBuilder<MoviesBloc, MoviesState>(
                    buildWhen: (previous, current) {
                      // Solo reconstruir si el estado actual es diferente del anterior
                      return previous != current &&
                          (current is DisplayMoviesLoaded ||
                              current is DisplayMoviesError);
                    },
                    builder: (context, state) {
                      if (state is DisplayMoviesLoading) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.4, // 40% de la altura de la pantalla
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is DisplayMoviesLoaded) {
                        // Verifica que state.movies no sea nulo
                        if (state.movies != null) {
                          return CardSwiper(movies: state.movies!);
                        } else {
                          return const Center(
                            child: Text('No movies available'),
                          );
                        }
                      } else if (state is DisplayMoviesError) {
                        return Center(
                          child: Text('Error: ${state.errorMessage}'),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  BlocBuilder<MoviesBloc, MoviesState>(
                    buildWhen: (previous, current) =>
                        current is PopularMoviesLoaded ||
                        current is PopularMoviesError,
                    builder: (context, state) {
                      if (state is PopularMoviesLoaded) {
                        return MovieSlider(
                          movies: state.popularMovies,
                          title: 'Populares', //opcional
                          onNextPage: () => context
                              .read<MoviesBloc>()
                              .add(GetPopularMovies()),
                        );
                      } else if (state is PopularMoviesError) {
                        return Center(
                            child: Text('Error: ${state.errorMessage}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

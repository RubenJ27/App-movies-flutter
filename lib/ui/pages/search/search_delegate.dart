import 'package:app_movies/ui/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => {close(context, null)},
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
        color: Colors.black38,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder<Object>(
        stream: moviesProvider.suggestionStream,
        builder: (context, snapshot) {
          return FutureBuilder(
            future: moviesProvider.searchMovies(query),
            builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
              if (!snapshot.hasData) return _emptyContainer();
              final movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) => _MovieItem(movies[index]),
              );
            },
          );
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}

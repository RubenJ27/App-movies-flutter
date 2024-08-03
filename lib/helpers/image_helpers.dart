// lib/helpers/image_helpers.dart

String getFullPosterImg(String? posterPath) {
  if (posterPath != null) {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
  return 'https://via.placeholder.com/300x400';
}

String getFullBackdropPath(String? backdropPath) {
  if (backdropPath != null) {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
  return 'https://via.placeholder.com/300x400';
}

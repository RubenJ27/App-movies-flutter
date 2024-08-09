// Mocks generated by Mockito 5.4.4 from annotations
// in app_movies/test/domain/common/blocs/movies_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:app_movies/domain/entities/movie.dart' as _i5;
import 'package:app_movies/domain/models/credits_response.dart' as _i6;
import 'package:app_movies/domain/repositories/movie_repository.dart' as _i3;
import 'package:logger/logger.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLogger_0 extends _i1.SmartFake implements _i2.Logger {
  _FakeLogger_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Logger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeLogger_0(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i2.Logger);

  @override
  _i4.Future<List<_i5.Movie>> getOnDisplayMovies() => (super.noSuchMethod(
        Invocation.method(
          #getOnDisplayMovies,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Movie>>.value(<_i5.Movie>[]),
      ) as _i4.Future<List<_i5.Movie>>);

  @override
  _i4.Future<List<_i5.Movie>> getOnPopularMovies(int? page) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnPopularMovies,
          [page],
        ),
        returnValue: _i4.Future<List<_i5.Movie>>.value(<_i5.Movie>[]),
      ) as _i4.Future<List<_i5.Movie>>);

  @override
  _i4.Future<List<_i6.Cast>> getOnMovieCast(int? movieId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnMovieCast,
          [movieId],
        ),
        returnValue: _i4.Future<List<_i6.Cast>>.value(<_i6.Cast>[]),
      ) as _i4.Future<List<_i6.Cast>>);

  @override
  _i4.Future<List<_i5.Movie>> getOnSearchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnSearchMovies,
          [query],
        ),
        returnValue: _i4.Future<List<_i5.Movie>>.value(<_i5.Movie>[]),
      ) as _i4.Future<List<_i5.Movie>>);

  @override
  void handleError(
    dynamic e,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #handleError,
          [
            e,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

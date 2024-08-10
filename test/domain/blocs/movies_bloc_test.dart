import 'package:app_movies/domain/blocs/movies_bloc.dart';
import 'package:app_movies/domain/entities/movie.dart';
import 'package:app_movies/domain/repositories/movie_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/movies_bloc_test.mocks.dart';

// La anotación @GenerateMocks se utiliza para generar clases mock para las clases
// especificadas.
@GenerateMocks([MovieRepository])
void main() {
  // Grupo de pruebas para verificar que el estado inicial de MoviesState es correcto
  group('MoviesState initialState', () {
    test('initialState returns correct initial values', () {
      final initialState = MoviesState.initialState();
      expect(initialState.movies, []);
      expect(initialState.isLoadingDisplayMovies, false);
      expect(initialState.errorMessage, '');
    });
  });

  // Grupo de pruebas para MoviesBloc
  group('MoviesBloc test', () {
    late MoviesBloc moviesBloc;
    late MockMovieRepository mockMovieRepository;

    // Arrange: Configuración inicial de la prueba
    setUp(() {
      mockMovieRepository = MockMovieRepository();
      moviesBloc = MoviesBloc(mockMovieRepository);
    });

    // Esta prueba verifica que el MoviesBloc emite los estados DisplayMoviesLoading
    //y MoviesDisplayLoaded
    // en secuencia cuando se agrega el evento GetOnDisplayMovies, simulando un caso de éxito.
    blocTest<MoviesBloc, MoviesState>(
      'emits [DisplayMoviesLoading, MoviesDisplayLoaded] cuando se agrega GetOnDisplayMovies (caso de exito)',
      // build: Crea y devuelve una instancia del Bloc que se va a probar
      build: () {
        print('Setting up mock repository');
        // Stubbing: Definición de la respuesta del método simulado
        when(mockMovieRepository.getOnDisplayMovies()).thenAnswer((_) async => [
              Movie(
                id: 1,
                title: 'Test Movie',
                adult: true,
                posterPath: '/9TFSqghEHrlBMRR63yTx80Orxva.jpg',
                backdropPath: '/9l1eZiJHmhr5jIlthMdJN5WYoff.jpg',
                originalLanguage: 'en',
                originalTitle: 'Deadpool & Wolverine',
                overview:
                    'Un apático Wade Wilson se afana en la vida civil tras dejar atrás sus días como Deadpool, un mercenario moralmente flexible. Pero cuando su mundo natal se enfrenta a una amenaza existencial, Wade debe volver a vestirse a regañadientes con un Lobezno aún más reacio a ayudar.',
                genreIds: [],
              ),
            ]);
        return moviesBloc;
      },
      act: (bloc) {
        // Act: Ejecución de la acción que se va a probar
        print('Adding GetOnDisplayMovies event');
        bloc.add(GetOnDisplayMovies());
      },
      expect: () => [
        // Assert: Verificación de los estados esperados
        isA<DisplayMoviesLoading>().having(
          (state) => state.isLoadingDisplayMovies,
          'isLoadingDisplayMovies',
          true,
        ),
        isA<MoviesDisplayLoaded>()
            .having(
              (state) => state.movies,
              'movies',
              isNotEmpty,
            )
            .having(
              (state) => state.isLoadingDisplayMovies,
              'isLoadingDisplayMovies',
              isFalse,
            ),
      ],
      verify: (_) {
        // Verify: Verificación de que el método simulado fue llamado
        print('Verifying method call');
        verify(mockMovieRepository.getOnDisplayMovies()).called(1);
      },
    );

    // Esta prueba verifica que el MoviesBloc emite los estados DisplayMoviesLoading y DisplayMoviesError
    // en secuencia cuando se agrega el evento GetOnDisplayMovies, simulando un caso de fallo.
    blocTest<MoviesBloc, MoviesState>(
      'emits [DisplayMoviesLoading, DisplayMoviesError] cuando se agrega GetOnDisplayMovies (caso de fallo)',
      build: () {
        // Arrange: Configuración inicial de la prueba
        print('Setting up mock repository for error case');
        // Stubbing: Definición de la respuesta del método simulado para el caso de error
        when(mockMovieRepository.getOnDisplayMovies())
            .thenThrow(Exception('Failed to fetch movies'));
        return moviesBloc;
      },
      act: (bloc) {
        // Act: Ejecución de la acción que se va a probar
        print('Adding GetOnDisplayMovies event for error case');
        bloc.add(GetOnDisplayMovies());
      },
      expect: () => [
        // Assert: Verificación de los estados esperados
        isA<DisplayMoviesLoading>().having(
          (state) => state.isLoadingDisplayMovies,
          'isLoadingDisplayMovies',
          true,
        ),
        isA<DisplayMoviesError>()
            .having(
              (state) => state.errorMessage,
              'errorMessage',
              contains('Failed to fetch movies'),
            )
            .having(
              (state) => state.isLoadingDisplayMovies,
              'isLoadingDisplayMovies',
              isFalse,
            ),
      ],
      verify: (_) {
        // Verify: Verificación de que el método simulado fue llamado
        print('Verifying method call for error case');
        verify(mockMovieRepository.getOnDisplayMovies()).called(1);
      },
    );
    //
  });

  // Grupo de pruebas para MoviesState
  group('MoviesState test', () {
    // Esta prueba verifica que el estado inicial MoviesInitial inicializa correctamente
    // las propiedades movies, message, errorMessage e isLoadingDisplayMovies.
    test('MoviesInitial debería tener las propiedades correctas', () {
      // ignore: prefer_const_constructors
      final state = MoviesInitial();
      expect(state.movies, []);
      expect(state.errorMessage, isNull);
      expect(state.isLoadingDisplayMovies, isFalse);
    });

    /*
      Esta prueba asegura que el estado MoviesState inicializa todas sus propiedades
      correctamente y que estas propiedades están incluidas en la lista props.
      */
    test(
      'Las propiedades de MoviesState deberían incluir todas las propiedades',
      () {
        const state = MoviesState(
          movies: [],
          isLoadingDisplayMovies: false,
          errorMessage: '',
        );
        expect(state.props, [
          state.movies,
          state.isLoadingDisplayMovies,
          state.errorMessage,
        ]);
      },
    );

    /*
      Esta prueba asegura que el estado DisplayMoviesLoading inicializa todas sus propiedades
      correctamente, incluyendo movies, isLoadingDisplayMovies, errorMessage y message.
      */
    test('DisplayMoviesLoading debería tener las propiedades correctas', () {
      // ignore: prefer_const_constructors
      final state = DisplayMoviesLoading();
      expect(state.movies, []);
      expect(state.isLoadingDisplayMovies, true);
      expect(state.errorMessage, isNull);
    });
  });

  // Grupo de pruebas para MoviesEvent
  group('MoviesEvent test', () {
    test('props are correct for GetOnDisplayMovies', () {
      final event = GetOnDisplayMovies();
      expect(event.props, []);
    });
  });

  // Grupo de pruebas para el método copyWith de MoviesState
  group('MoviesState copyWith method', () {
    const initialState = MoviesState(
      movies: [],
      isLoadingDisplayMovies: false,
      errorMessage: '',
    );

    test('copyWith sin parámetros devuelve el mismo estado', () {
      final newState = initialState.copyWith();
      expect(newState.movies, initialState.movies);
      expect(
          newState.isLoadingDisplayMovies, initialState.isLoadingDisplayMovies);
      expect(newState.errorMessage, initialState.errorMessage);
    });

    test(
        'copyWith con múltiples parámetros cambia todos los parámetros especificados',
        () {
      final newMovies = [
        Movie(
          id: 1,
          title: 'Test Movie',
          adult: true,
          posterPath: '/path.jpg',
          backdropPath: '/backdrop.jpg',
          originalLanguage: 'en',
          originalTitle: 'Test Movie',
          overview: 'Overview',
          genreIds: [],
        ),
      ];
      const newErrorMessage = 'New error message';
      const newMessage = 'New message';
      final newState = initialState.copyWith(
        movies: newMovies,
        isLoadingDisplayMovies: true,
        errorMessage: newErrorMessage,
        message: newMessage,
      );
      expect(newState.movies, newMovies);
      expect(newState.isLoadingDisplayMovies, true);
      expect(newState.errorMessage, newErrorMessage);
    });
  });
}


// Al realizar pruebas, no utilice constpalabras clave, ese suele ser el problema.
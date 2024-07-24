import 'package:app_movies/ui/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/pages/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.blue),
      ),
    );
  }
}

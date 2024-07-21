import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/incidence_provider.dart';
import 'screens/home_page.dart';
import 'models/incidence.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(IncidenceAdapter());
  await Hive.openBox<Incidence>('incidences');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncidenceProvider()),
      ],
      child: MaterialApp(
        title: 'App de Vigilancia',
        theme: ThemeData(
          brightness: Brightness.light, // Tema claro
          primaryColor: Colors.pinkAccent,
          colorScheme: ColorScheme.light(
            primary: Colors.pinkAccent,
            secondary: Colors.purpleAccent,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black87),
            titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.pinkAccent,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.pinkAccent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

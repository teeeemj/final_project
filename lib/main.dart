import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/theme_provider.dart';
import 'package:flutter_application_1/data/network/dio_settings.dart';
import 'package:flutter_application_1/data/repositories/weather_repository.dart';
import 'package:flutter_application_1/data/services/location_service.dart';
import 'package:flutter_application_1/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_application_1/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_application_1/presentation/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => WeatherRepository(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CounterBloc(),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(
              location: LocationService(),
              repository: RepositoryProvider.of<WeatherRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          themeMode: Provider.of<ThemeProvider>(context).currentTheme,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        ),
      ),
    );
  }
}

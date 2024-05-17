import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/theme_provider.dart';
import 'package:flutter_application_1/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_application_1/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('WeatherApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              log(state.toString());
              if (state is WeatherLoading) {
                return const CircularProgressIndicator();
              }
              if (state is WeatherSuccess) {
                final temp = state.weather.main?.temp;
                if (temp != null) {
                  return Text(temp.toString());
                } else {
                  return const Text('Temperature is unavailable');
                }
              }
              if (state is WeatherError) {
                return Text(state.errorText.toString());
              }
              return const SizedBox();
            }),
            const Text('Press the icon to get your location'),
            const SizedBox(height: 23),
            const Text('You have pushed the button this many times:'),
            const SizedBox(height: 10),
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  '$state',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<WeatherBloc>(context).add(GetWeather());
                      },
                      child: const Icon(Icons.sticky_note_2),
                    ),
                    const SizedBox(height: 30),
                    FloatingActionButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                      child: const Icon(Icons.palette_outlined),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        final themeProvider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        final incrementValue = themeProvider.isDarkMode ? 2 : 1;
                        BlocProvider.of<CounterBloc>(context)
                            .add(Increment(incrementValue: incrementValue));
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 30),
                    FloatingActionButton(
                      onPressed: () {
                        final themeProvider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        final decrementValue = themeProvider.isDarkMode ? 2 : 1;
                        BlocProvider.of<CounterBloc>(context)
                            .add(Decrement(decrementValue: decrementValue));
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

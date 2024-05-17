part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weather;

  WeatherSuccess({required this.weather});
}

final class WeatherError extends WeatherState {
  final String errorText;

  WeatherError({required this.errorText});
}

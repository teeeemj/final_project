import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/models/weather_model.dart';
import 'package:flutter_application_1/data/repositories/weather_repository.dart';
import 'package:flutter_application_1/data/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository repository;
  LocationService location;
  WeatherBloc({required this.repository, required this.location})
      : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        Position position = await location.determinePosition();
        WeatherModel weather = await repository.getWeather(
          lat: position.latitude,
          lon: position.longitude,
        );

        emit(
          WeatherSuccess(
            weather: weather,
          ),
        );
      } catch (e) {
        emit(WeatherError(errorText: e.toString()));
      }
    });
  }
}

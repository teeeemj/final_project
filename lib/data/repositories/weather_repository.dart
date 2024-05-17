import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/models/weather_model.dart';

class WeatherRepository {
  final Dio dio;

  WeatherRepository({required this.dio});

  Future<WeatherModel> getWeather(
      {required double lat, required double lon}) async {
    final Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=f7415ad9524b95fa2a963951e78fdca7&units=metric');

    return WeatherModel.fromJson(response.data);
  }
}

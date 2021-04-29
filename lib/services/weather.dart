import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

String apiKey = 'fc72f572e17602a9e161c0cb2949f443';

class WeatherModel {
  Future<dynamic> getMyCityData(String city) async {
    print(city);
    NetworkHelper networkCity = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');

    var weather = await networkCity.getdata();

    return weather;
  }

  Future<dynamic> getMyweatherdata() async {
    Location location = Location();
    await location.getMyLocation();

    double latitude = location.latitude;
    double longitude = location.longitude;
    print(latitude);
    print(longitude);

    NetworkHelper network = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    var weather = await network.getdata();
    return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

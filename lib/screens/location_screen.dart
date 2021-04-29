import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherdata});
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

double temp;
int id;
String city;
String weatherIcon;
String weatherMsg;

class _LocationScreenState extends State<LocationScreen> {
  void initState() {
    super.initState();
    updateUi(widget.weatherdata);
  }

  void updateUi(dynamic weather) {
    setState(() {
      if (weather == null) {
        temp = 0;
        city = '';
        weatherMsg = 'error';
        weatherIcon = 'null';
        return;
      }
      print(weather);
      temp = weather['main']['temp'];

      city = weather['name'];

      id = weather['weather'][0]['id'];
      WeatherModel weatherModel = WeatherModel();
      weatherIcon = weatherModel.getWeatherIcon(id);
      weatherMsg = weatherModel.getMessage(temp.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      print('change');
                      var weatherData = await WeatherModel().getMyweatherdata();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));

                      print(typedName);
                      if (typedName != null) {
                        var myCitydata =
                            await WeatherModel().getMyCityData(typedName);
                        updateUi(myCitydata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt().toString()}',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMsg + 'in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

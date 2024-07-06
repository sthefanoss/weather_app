class CurrentWeatherResponse {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibilityInMeters;
  final Wind wind;
  final Clouds clouds;
  final Rain? rain;
  final Snow? snow;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  CurrentWeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibilityInMeters,
    required this.wind,
    required this.clouds,
    this.rain,
    this.snow,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List).map((i) => Weather.fromJson(i)).toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibilityInMeters: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? Snow.fromJson(json['snow']) : null,
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({required this.id, required this.main, required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;
  final int? seaLevel;
  final int? grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double? gust;

  Wind({required this.speed, required this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust']?.toDouble(),
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Rain {
  final double? oneHour;
  final double? threeHours;

  Rain({this.oneHour, this.threeHours});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      oneHour: json['1h']?.toDouble(),
      threeHours: json['3h']?.toDouble(),
    );
  }
}

class Snow {
  final double? oneHour;
  final double? threeHours;

  Snow({this.oneHour, this.threeHours});

  factory Snow.fromJson(Map<String, dynamic> json) {
    return Snow(
      oneHour: json['1h']?.toDouble(),
      threeHours: json['3h']?.toDouble(),
    );
  }
}

class Sys {
  final int? type;
  final int? id;
  final double? message;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    this.type,
    this.id,
    this.message,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      message: json['message']?.toDouble(),
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

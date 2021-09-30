class Weather {
  String city; //nome da cidade
  String date; // data da consulta
  String time; // hora da consulta
  int maxTemp; // maximo tempo
  int minTemp; // mininmo tempo
  int temp; // temperatura atual em ºC
  String
      description; // descrição da condição de tempo atual no idioma escolhido
  int humidity; // umidade atual em percentual
  String sunrise; //  nascer do sol em horário local da cidade
  String sunset; // pôr do sol em horário local da cidade
  String conditionSlug; // slug da condição de tempo atual

  factory Weather.fromJson(Map<String, dynamic> jsonMap) {
    return Weather(
        city: jsonMap['results']['city'],
        date: jsonMap['results']['date'],
        time: jsonMap['results']['time'],
        maxTemp: jsonMap['results']['forecast'][0]['max'],
        minTemp: jsonMap['results']['forecast'][0]['min'],
        temp: jsonMap['results']['temp'],
        description: jsonMap['results']['description'],
        humidity: jsonMap['results']['humidity'],
        sunrise: jsonMap['results']['sunrise'],
        sunset: jsonMap['results']['sunset'],
        conditionSlug: jsonMap['results']['condition_slug']);
  }

  Weather({
    required this.city,
    required this.date,
    required this.time,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.description,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.conditionSlug,
  });
}

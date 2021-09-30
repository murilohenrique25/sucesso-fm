import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sucesso_jm/model/weather.dart';

Future<Weather> getWeather() async {
  var url =
      Uri.parse('https://api.hgbrasil.com/weather?key=a7eb0e1e&woeid=456912');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception('Deu ruim');
  }
}

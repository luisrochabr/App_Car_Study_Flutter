import 'dart:convert';

import 'package:carros/carro/carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url =
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

    print("Get > $url");

    http.Response response = await http.get(url);

    List list = json.decode(response.body);

    final List<Carro> carros =
        list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}

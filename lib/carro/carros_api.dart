import 'package:carros/carro/carro.dart';
import 'package:carros/login/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map<String,String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url =
        'https://XXXXXcarros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("Get > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;
    
    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();
    return carros;
  }
}

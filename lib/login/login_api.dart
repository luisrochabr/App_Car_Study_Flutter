import 'dart:convert';
import 'package:carros/login/api_response.dart';
import 'package:carros/login/usuario.dart';
import 'package:carros/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiReponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String,String> headers = {
        "Content-Type": "application/json"
      };

      Map params = {
        'username': login,
        'password': senha,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if(response.statusCode == 200){
        final user = Usuario.fromJson(mapResponse);

        user.save();

        return ApiReponse.ok(user);
      }

      return ApiReponse.erro(mapResponse["error"]);
    } catch(error, exception){
      print("Error no login $error > $exception");
      return ApiReponse.erro("Não foi possível realizar o login");
    }
  }
}

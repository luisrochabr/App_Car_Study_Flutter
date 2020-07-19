import 'package:carros/login/api_response.dart';
import 'package:carros/login/login_api.dart';
import 'package:carros/login/usuario.dart';
import 'package:carros/widgets/simple_bloc.dart';

class LoginBloc extends BooleanBloc {

  Future<ApiReponse<Usuario>> login(String login, String senha) async {

    add(true);

    ApiReponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}

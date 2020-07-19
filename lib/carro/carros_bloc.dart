import 'package:carros/carro/carro.dart';
import 'package:carros/carro/carros_api.dart';
import 'package:carros/widgets/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (e) {
      addError(e);
    }
  }


}
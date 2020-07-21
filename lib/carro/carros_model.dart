import 'package:carros/carro/carro.dart';
import 'package:carros/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {

  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  fetch(String tipo) async {
    try {
      error = null;

      this.carros = await CarrosApi.getCarros(tipo);

    } catch (e) {
      this.error = e;
    }
  }
}
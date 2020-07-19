import 'dart:async';

import 'package:carros/carro/carro.dart';
import 'package:carros/carro/carro_page.dart';
import 'package:carros/carro/carros_api.dart';
import 'package:carros/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView>{
  List<Carro> carros;
  String get tipo => widget.tipo;
  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc.fetch(tipo);
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);


    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscas os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[200],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Image.network(
                    c.urlFoto ??
                        "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png",
                    width: 250,
                  ),
                  Text(
                    c.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () => _onClickCarro(c),
                      ),
                      FlatButton(
                        child: const Text('SHARE'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance/stock_price?key=79bbfc61&symbol=";

Future<Map> getData(String acao) async {
  http.Response response = await http.get(request + acao);
  return json.decode(response.body);
}

class Result extends StatelessWidget {
  String _simbolo;

  Result(this._simbolo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Resultado"),
            backgroundColor: Colors.blueGrey.shade900),
        backgroundColor: Colors.white,
        body: FutureBuilder<Map>(
            future: getData(_simbolo),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando dados...",
                    style: TextStyle(
                        color: Colors.blueGrey.shade900, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(
                          color: Colors.blueGrey.shade900, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.insert_chart,
                              size: 150.0, color: Colors.blueGrey.shade900),
                          Text("Símbolo: " + _simbolo,
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 20.0)),
                          Divider(),
                          Text(
                              "Nome: " +
                                  snapshot.data["results"][_simbolo]["name"]
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 20.0)),
                          Divider(),
                          Text(
                              "Descricao: " +
                                  snapshot.data["results"][_simbolo]
                                          ["description"]
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 20.0)),
                          Divider(),
                          Text(
                              "Preço: " +
                                  snapshot.data["results"][_simbolo]["price"]
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 20.0)),
                          Divider(),
                          Text(
                              "Última atualização: " +
                                  snapshot.data["results"][_simbolo]
                                          ["updated_at"]
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 20.0)),
                        ],
                      ),
                    );
                  }
              }
            }));
  }

  // _pesquisar() {
  //   return Container(
  //       child: FutureBuilder(
  //           future: getData(_simbolo),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               return Center(
  //                 child: Text(
  //                   snapshot.data["results"][_simbolo]["name"]
  //                       .toString(),
  //                   style: TextStyle(fontSize: 20.0),
  //                 ),
  //               );
  //             } else {
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             }
  //           }));
  // }
}

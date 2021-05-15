import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:stock_search/result.dart';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.blueGrey.shade900,
      primaryColor: Colors.blueGrey.shade900,
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final acaoController = TextEditingController();

  String acao;
  String _texto = "";
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _limpar() {
    acaoController.text = "";
    _texto = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Stock Search"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Ação",
                    labelStyle: TextStyle(color: Colors.blueGrey.shade900)),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.blueGrey.shade900, fontSize: 25.0),
                controller: acaoController,
                validator: (value) {
                  if (value.isEmpty) return "Insira uma ação!";
                },
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _pesquisar();
                              }
                            },
                            child: Text(
                              "Pesquisar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            color: Colors.blueGrey.shade900)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _limpar();
                              }
                            },
                            child: Text(
                              "Limpar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            color: Colors.blueGrey.shade900)),
                  ),
                ],
              ),
              Text(_texto),
            ],
          ),
        ),
      ),
    );
  }

  _pesquisar() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Result(acaoController.text.toUpperCase().toString())));
  }
}

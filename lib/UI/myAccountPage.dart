import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/detailsList.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:nome_na_lista/model/allMyListsModel.dart';
import 'package:nome_na_lista/model/listCreateModel.dart';
import 'package:nome_na_lista/model/listModel.dart';
import 'package:nome_na_lista/repository/listRepository.dart';
import 'package:nome_na_lista/widget/HeaderMyAccount.dart';
import 'package:nome_na_lista/widget/contentBodyMyAccount.dart';
import 'package:nome_na_lista/widget/nlButtonLogout.dart';
import 'package:nome_na_lista/widget/subtitleMyAccount.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String _nameList;
  String _description;
  String _password;
  bool _loading = false;
  bool busy = false;

  final _streamController = StreamController<List<ListaModel>>();
  final ListaRepository _listaRepository = new ListaRepository();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  _loadList() async {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    await _listaRepository.getAllMyLists(bloc.id).then((value) {
      List<ListaModel> lists = value;
      _streamController.add(lists);
      setState(() {
        busy = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneWidht = MediaQuery.of(context).size.width;
    final phoneHeigth = MediaQuery.of(context).size.height;

    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    _futureInfoBody() {
      return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
                child: Text("Erro ao carregar dados, tente novamente!"));

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          List<ListaModel> lists = snapshot.data;
          return ContentBodyMyAccount(
            listas: lists,
          );
        },
      );
    }

    Widget _buildName() {
      return TextFormField(
        decoration: InputDecoration(labelText: "Nome da Lista"),
        validator: (String value) {
          if (value.isEmpty) return "Campo Obrigatório";

          if (value.length < 3) return "Campo tem que ter mais de 3 caracteres";
        },
        onSaved: (String value) {
          _nameList = value;
        },
      );
    }

    Widget _buildDescription() {
      return TextFormField(
        decoration: InputDecoration(labelText: "Descrição"),
        validator: (String value) {
          if (value.isEmpty) return "Campo Obrigatório";

          if (value.length <= 10)
            return "O campo não pode ter menos de 10 caracteres";
        },
        onSaved: (String value) {
          _description = value;
        },
      );
    }

    Widget _buildPass() {
      return TextFormField(
        decoration: InputDecoration(labelText: "Senha para entrar"),
        validator: (String value) {
          if (value.isEmpty) return "Campo Obrigatório";
        },
        onSaved: (String value) {
          _password = value;
        },
      );
    }

    Future<String> _showAddList(BuildContext context) {
      TextEditingController customController = TextEditingController();
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 100,
              height: 250,
              child: Column(
                children: <Widget>[
                  _loading
                      ? CircularProgressIndicator()
                      : Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              _buildName(),
                              _buildDescription(),
                              _buildPass(),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  if (!_formKey.currentState.validate())
                    return "Campos inválidos";

                  _formKey.currentState.save();

                  Navigator.pop(context);
                  setState(() {
                    busy = true;
                  });

                  var newlist = CreateListaModel(
                    name: _nameList,
                    description: _description,
                    criadorId: bloc.id,
                    pass: _password,
                    start: DateTime.now(),
                  );

                  _listaRepository.createList(newlist).then((value) {
                    _loadList();
                  }).catchError((onError) {
                    var snackbar = new SnackBar(
                        content:
                            new Text("Falha ao criar! Verifique sua conexão."));
                    scaffoldKey.currentState.showSnackBar(snackbar);
                  });
                },
                elevation: 5.0,
                child: Text("Entrar"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFf1f1f1),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Criar Lista",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 13,
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color(0xff4f5b66),
        onPressed: () {
          _showAddList(context);
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: phoneWidht,
            height: 220,
            child: Stack(
              children: <Widget>[
                HeaderMyAccount(phoneHeigth: phoneHeigth),
                NLButtonSingout()
              ],
            ),
          ),
          SubTitleMyAccount(),
          Expanded(
            child: _futureInfoBody(),
          ),
        ],
      ),
    );
  }
}

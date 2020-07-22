import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/searchUserPage.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/model/deleteListaModel.dart';
import 'package:nome_na_lista/model/listModel.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/repository/listRepository.dart';
import 'package:nome_na_lista/repository/userRepository.dart';
import 'package:nome_na_lista/widget/dialogs.dart';
import 'package:nome_na_lista/widget/searchBarUsers.dart';

class DetailsList extends StatefulWidget {
  final String idList;
  final ListaModel lista;

  DetailsList({
    @required this.idList,
    @required this.lista,
  });

  @override
  _DetailsListState createState() => _DetailsListState();
}

List<UserModel> list;

class _DetailsListState extends State<DetailsList> {
  final UserRepository _userRepository = new UserRepository();
  final _streamController = StreamController<List<UserModel>>();
  final ListaRepository _listaRepository = new ListaRepository();
  var _searchview = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  _loadUsers() async {
    await _userRepository
        .getAllUserOfListByListaId(widget.idList)
        .then((value) {
      list = value;
      _streamController.add(list);
    });
  }

  _deleteList() {
    var newlista = new DeleteListaModel(
      idList: widget.lista.id,
    );
    _listaRepository.deleteLista(newlista).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TabsPage(
          paramIndex: 1,
        );
      }));
    }).catchError((onError) {
      SnackBar mySnackBar = SnackBar(
        content: Text("Erro verifique sua conexão."),
      );
      Scaffold.of(context).showSnackBar(mySnackBar);
    });
  }

  _showConfirmDelete() {
    return showDialog(
      context: context,
      builder: (_) => NLDialog(
        context: context,
        title: 'Confirmação',
        subTitle: 'Deseja realmente deleter essa lista?',
        image:
            "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
        textButtonOK: "Confirmo",
        textButtonCancel: "Cancelar",
        funcButtonCancel: () {
          return Navigator.pop(context);
        },
        funcButtonOk: () {
          _deleteList();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeigth = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4f5b66),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchUserPage(userList: list);
          }));
        },
        label: Text("Pesquisar Usuários"),
        icon: Icon(Icons.search),
        backgroundColor: Color(0xff4f5b66),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: Container(
                    height: phoneHeigth * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                      ),
                      color: Color(0xff4f5b66),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListTile(
                            title: Text(
                              "Lista: " + widget.lista.name,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            subtitle: Text("Desc: " + widget.lista.description,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Cod: " + widget.lista.codigo,
                                style: TextStyle(
                                    fontFamily: "Poppnins",
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                              Text("Senha: " + widget.lista.password,
                                  style: TextStyle(
                                      fontFamily: "Poppnins",
                                      color: Colors.white,
                                      fontSize: 15))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: phoneWidth / 1.8,
                  top: phoneHeigth / 5.2,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[200],
                    ),
                    child: FlatButton(
                      child: Text("Deletar Lista"),
                      onPressed: () {
                        _showConfirmDelete();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                    child: Text("Erro ao carregar dados, tente novamente!"));

              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              List<UserModel> users = snapshot.data;
              return CardUserOfList(
                users: users,
                lista: widget.lista,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardUserOfList extends StatelessWidget {
  final List<UserModel> users;
  final ListaModel lista;
  final ListaRepository _listaRepository = new ListaRepository();

  CardUserOfList({
    @required this.users,
    @required this.lista,
  });

  @override
  Widget build(BuildContext context) {
    var phoneHeigth = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return users.length == 0
        ? Center(child: Text("Nenhum Inscrito"))
        : Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: NetworkImage(users[index].photo))),
                      ),
                      title: Text(
                        users[index].fristName + users[index].lastName,
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      subtitle: Text(users[index].email,
                          style: TextStyle(fontFamily: "Poppins")),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

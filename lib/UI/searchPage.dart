import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:nome_na_lista/model/createUserList.dart';
import 'package:nome_na_lista/model/deleteUserList.dart';
import 'package:nome_na_lista/model/listModel.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/model/usersListaModel.dart';
import 'package:nome_na_lista/repository/listRepository.dart';
import 'package:nome_na_lista/repository/userListaRepository.dart';
import 'package:nome_na_lista/repository/userRepository.dart';
import 'package:nome_na_lista/widget/dialogs.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isAdd = false;
  bool _isLoad = false;
  bool _iHaveBeenAdd = false;
  ListaModel _listaFinal;
  List<UserModel> _usersOfListaFinal;

  @override
  Widget build(BuildContext context) {
    final phoneWidht = MediaQuery.of(context).size.width;
    final phoneHeigth = MediaQuery.of(context).size.height;
    final ListaRepository _listRepository = new ListaRepository();
    final UserRepository _userRepository = new UserRepository();
    final UserListaRepository _userListaRepository = new UserListaRepository();
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);

    String _codLista;
    bool _isCodValido = false;
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    Future<String> _showSearchList(BuildContext context) {
      TextEditingController customController = TextEditingController();

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 100,
              height: 100,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Senha da lista"),
                    controller: customController,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
                elevation: 5.0,
                child: Text("Entrar"),
              ),
            ],
          );
        },
      );
    }

    _addInList() {
      final InfoUserBloc bloc =
          Provider.of<InfoUserBloc>(context, listen: false);

      var myUser = new UsersListModel(
          email: bloc.userEmail,
          fristName: bloc.firstName,
          id: bloc.id,
          idFacebook: "",
          lastName: bloc.lastName,
          phone: bloc.phone);

      setState(() {
        bloc.addUserInList(myUser);
      });

      SnackBar mySnackBar = SnackBar(
        content: Text("Adicionado, não esqueça de salvar!"),
      );
      Scaffold.of(context).showSnackBar(mySnackBar);

      setState(() {
        _isAdd = true;
      });
    }

    _removeOfList() {
      return showDialog(
        context: context,
        builder: (_) => BstageDialog(
          context: context,
          title: 'Remover',
          subTitle: 'Deseja remover seu nome da lista?',
          image:
              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
          textButtonOK: "Sim",
          textButtonCancel: "Cancelar",
          funcButtonCancel: () {
            return Navigator.pop(context);
          },
          funcButtonOk: () {
            bloc.removeUserInList();
            print(bloc.usersOfList);
            var userlist = new DeleteUserListaModel(
              listId: _listaFinal.id,
              userId: bloc.id,
            );
            _userListaRepository.deleteUserList(userlist).then((value) {
              SnackBar mySnackBar = SnackBar(
                content: Text("Você foi removido"),
              );
              Scaffold.of(context).showSnackBar(mySnackBar);

              setState(() {
                _isLoad = false;
                _isAdd = false;
                _iHaveBeenAdd = false;
              });
              Navigator.pop(context);
            });
          },
        ),
      );
    }

    NMFloatingActionButtonSearch() {
      return FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Color(0xff4f5b66),
        onPressed: () {
          if (!_formKey.currentState.validate()) return;

          _formKey.currentState.save();

          _listRepository.getByList(_codLista).then(
            (value) {
              print(value);
              if (value.codigo == "") {
                SnackBar mySnackBar = SnackBar(
                  content: Text("Codigo inválido"),
                );
                Scaffold.of(context).showSnackBar(mySnackBar);
              } else {
                _listaFinal = value;
                _showSearchList(context).then((value) {
                  if (value == _listaFinal.password) {
                    SnackBar mySnackBar = SnackBar(
                      content: Text("Senha correto"),
                    );

                    _userRepository
                        .getAllUserOfListByListaId(_listaFinal.id)
                        .then((value) {
                      value.forEach((element) {
                        if (element.id.toUpperCase() == bloc.id.toUpperCase()) {
                          _iHaveBeenAdd = true;
                        }
                      });
                      bloc.addCompleteValueinList(value);

                      setState(() {
                        _isLoad = true;
                      });
                    });

                    Scaffold.of(context).showSnackBar(mySnackBar);
                  } else {
                    SnackBar mySnackBar = SnackBar(
                      content: Text("Senha Inválido"),
                    );
                    Scaffold.of(context).showSnackBar(mySnackBar);
                  }
                });
              }
            },
          );
        },
      );
    }

    _saveAdd() {
      var newUserInList = new CreateUserListaModel(
        idLista: _listaFinal.id,
        idUser: bloc.id,
        register: DateTime.now(),
      );

      _userListaRepository.insertUserInList(newUserInList).then((value) {
        SnackBar mySnackBar = SnackBar(
          content: Text("Adicionado, não esqueça de salvar!"),
        );
        Scaffold.of(context).showSnackBar(mySnackBar);

        setState(() {
          _isLoad = false;
          _isAdd = false;
        });
      });
    }

    _showDialogToConfirmAdd() {
      return showDialog(
        context: context,
        builder: (_) => BstageDialog(
          context: context,
          title: 'Confirmação',
          subTitle: 'Confirma adicionar seu nome nesta lista?',
          image:
              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
          textButtonOK: "Confirmo",
          textButtonCancel: "Cancelar",
          funcButtonCancel: () {
            return Navigator.pop(context);
          },
          funcButtonOk: () {
            _saveAdd();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TabsPage();
            }));
          },
        ),
      );
    }

    Widget NMFloatingActionButtonAddRmv() {
      return _iHaveBeenAdd
          ? FloatingActionButton.extended(
              label: Text("Você já está adicionado. Clique para remover."),
              onPressed: _removeOfList,
            )
          : FloatingActionButton(
              child: Icon(_isAdd ? Icons.save : Icons.add),
              backgroundColor: _isAdd ? Colors.blue : Colors.green,
              onPressed: _isAdd ? _showDialogToConfirmAdd : _addInList,
            );
    }

    return Scaffold(
      backgroundColor: Color(0xFFf1f1f1),
      floatingActionButton: _isLoad
          ? NMFloatingActionButtonAddRmv()
          : NMFloatingActionButtonSearch(),
      body: Column(
        children: <Widget>[
          Container(
            width: phoneWidht,
            height: 220,
            color: Color(0xFFf1f1f1),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Pesquise uma Lista",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 70,
                  top: 150,
                  child: Container(
                    width: phoneWidht * 0.8,
                    height: phoneHeigth * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _isLoad
                          ? FlatButton(
                              child: Text(
                                "Pesquisar outra Lista",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 19,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  bloc.usersOfList = [];
                                  _isLoad = false;
                                  _isAdd = false;
                                });
                              },
                            )
                          : Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Código",
                                  labelStyle: TextStyle(fontFamily: "Poppins"),
                                  contentPadding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) return "Campo inválido";
                                },
                                onSaved: (String value) {
                                  _codLista = value;
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // _isLoad ? ContentListHeader(18) : Center(),
          _isLoad ? ContentListBody(context) : Center(),
        ],
      ),
    );
  }
}

Widget _loadingUsers(BuildContext context, String listaId) {
  final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
  final UserRepository _userRespository = new UserRepository();
  return FutureBuilder<List<UsersListModel>>(
    future: _userRespository.getAllUserOfListByListaId(listaId),
    builder: (context, snapshot) {
      List<UsersListModel> users = snapshot.data;
      bloc.usersOfList = users;
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Container(
            height: 0.38 * MediaQuery.of(context).size.height,
            child: Text('Aguardando...'),
          );
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Container(
            height: 0.38 * MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case ConnectionState.done:
          if (snapshot.hasError)
            return Container(
              height: 0.38 * MediaQuery.of(context).size.height,
              child: Center(
                child: Text(
                  "Não foi possível obter os eventos, favor conectar a internet",
                ),
              ),
            );
          return Center();
      }
      return null;
    },
  );
}

Widget ContentListHeader(int totalNameInList) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        "Pessoas da Lista",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "Total: ${totalNameInList}",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Widget ContentListBody(BuildContext context) {
  final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
  return Expanded(
    child: ListView.builder(
      itemCount: bloc.usersOfList.length,
      itemBuilder: (context, index) {
        return InfoUserOfList(
          name: bloc.usersOfList[index].fristName +
              ' ' +
              bloc.usersOfList[index].lastName,
          email: bloc.usersOfList[index].email,
        );
      },
    ),
  );
}

class InfoUserOfList extends StatefulWidget {
  final String name;
  final String email;

  InfoUserOfList({
    @required this.name,
    @required this.email,
  });

  @override
  _InfoUserOfListState createState() => _InfoUserOfListState();
}

class _InfoUserOfListState extends State<InfoUserOfList> {
  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

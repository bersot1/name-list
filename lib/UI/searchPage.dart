import 'package:flutter/material.dart';
import 'package:nome_na_lista/model/listModel.dart';
import 'package:nome_na_lista/repository/listRepository.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isAdd = false;
  bool _isLoad = false;

  @override
  Widget build(BuildContext context) {
    final phoneWidht = MediaQuery.of(context).size.width;
    final phoneHeigth = MediaQuery.of(context).size.height;
    final ListaRepository _listRepository = new ListaRepository();
    String _codLista;
    bool _isCodValido = false;
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    ListaModel _listaFinal;

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
      SnackBar mySnackBar = SnackBar(
        content: Text("Você foi adicionado na Lista"),
      );
      Scaffold.of(context).showSnackBar(mySnackBar);

      setState(() {
        _isAdd = true;
      });
    }

    _removeInList() {
      SnackBar mySnackBar = SnackBar(
        content: Text("Você foi removido da Lista"),
      );
      Scaffold.of(context).showSnackBar(mySnackBar);
      setState(() {
        _isAdd = false;
      });
    }

    // Future<ListaModel> _searchList() async {
    //   await
    // }

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
                      content: Text("Codigo correto"),
                    );
                    Scaffold.of(context).showSnackBar(mySnackBar);
                  } else {
                    SnackBar mySnackBar = SnackBar(
                      content: Text("Codigo Inválido"),
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

    Widget NMFloatingActionButtonAddRmv() {
      return FloatingActionButton(
        child: Icon(_isAdd ? Icons.remove : Icons.add),
        backgroundColor: _isAdd ? Colors.red : Colors.green,
        onPressed: _isAdd ? _removeInList : _addInList,
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
                                  _isLoad = false;
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
          // _isLoad ? ContentListBody() : Center(),
        ],
      ),
    );
  }
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

Widget ContentListBody() {
  return Expanded(
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return InfoUserOfList(
          name: "Lucas Bersot" + index.toString(),
          urlImg: "wewqeqwe",
        );
      },
    ),
  );
}

class InfoUserOfList extends StatelessWidget {
  final String urlImg;
  final String name;

  InfoUserOfList({
    @required this.urlImg,
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          width: double.infinity,
          height: 75,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 19,
                ),
              )
            ],
          )),
    );
  }
}

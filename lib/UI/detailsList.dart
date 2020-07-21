import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/repository/userRepository.dart';

class DetailsList extends StatefulWidget {
  final String idList;

  DetailsList({
    @required this.idList,
  });

  @override
  _DetailsListState createState() => _DetailsListState();
}

List<UserModel> list;

class _DetailsListState extends State<DetailsList> {
  final UserRepository _userRepository = new UserRepository();
  final _streamController = StreamController<List<UserModel>>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
          );
        },
      ),
    );
  }
}

class CardUserOfList extends StatelessWidget {
  final List<UserModel> users;
  const CardUserOfList({
    @required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
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
              }),
        )
      ],
    );
  }
}

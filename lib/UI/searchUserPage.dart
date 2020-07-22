import 'package:flutter/material.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/widget/searchBarUsers.dart';

class SearchUserPage extends StatefulWidget {
  final List<UserModel> userList;

  SearchUserPage({
    @required this.userList,
  });

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";

  List<UserModel> _filterUser;

  _SearchUserPageState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  Widget _usersSearch() {
    var _filterList = new List<UserModel>();

    for (int i = 0; i < widget.userList.length; i++) {
      var user = widget.userList[i].fristName;
      if (user.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(widget.userList[i]);
      }
    }
    return UsersListCard(
      listUser: _filterList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4f5b66),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(context: context, controller: _searchview),
          ),
          _firstSearch
              ? UsersListCard(listUser: widget.userList)
              : _usersSearch(),
        ],
      ),
    );
  }
}

class UsersListCard extends StatelessWidget {
  List<UserModel> listUser;

  UsersListCard({
    @required this.listUser,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listUser.length,
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
                          image: NetworkImage(listUser[index].photo))),
                ),
                title: Text(
                  listUser[index].fristName + ' ' + listUser[index].lastName,
                  style: TextStyle(fontFamily: "Poppins"),
                ),
                subtitle: Text(listUser[index].email,
                    style: TextStyle(fontFamily: "Poppins")),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/login.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:provider/provider.dart';

class NLButtonSingout extends StatelessWidget {
  const NLButtonSingout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context);
    var phoneWidth = MediaQuery.of(context).size.width;
    var phoneHeight = MediaQuery.of(context).size.height;
    return Positioned(
      left: phoneWidth / 2,
      top: phoneHeight / 4.7,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red[200],
        ),
        child: FlatButton(
          child: Text("Sair"),
          onPressed: () {
            bloc.sigOut();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Login();
            }));
          },
        ),
      ),
    );
  }
}

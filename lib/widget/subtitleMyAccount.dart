import 'package:flutter/material.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:provider/provider.dart';

class SubTitleMyAccount extends StatelessWidget {
  const SubTitleMyAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              "Todas suas Listas",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            subtitle: Text(
                "Compartilhe o código para as pessoas entrarem na sua lista"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:nome_na_lista/widget/infoUserofList.dart';
import 'package:provider/provider.dart';

class ContentListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    return Expanded(
      child: ListView.builder(
        itemCount: bloc.usersOfList.length,
        itemBuilder: (context, index) {
          return InfoUserOfList(
            name: bloc.usersOfList[index].fristName +
                '  ' +
                bloc.usersOfList[index].lastName,
            email: bloc.usersOfList[index].email,
            photo: bloc.usersOfList[index].photo,
          );
        },
      ),
    );
  }
}

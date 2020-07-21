import 'package:flutter/material.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:provider/provider.dart';

class InfoUserOfList extends StatefulWidget {
  final String photo;
  final String name;
  final String email;

  InfoUserOfList({
    @required this.photo,
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(image: NetworkImage(widget.photo))),
            ),
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

import 'package:flutter/material.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:provider/provider.dart';

class HeaderMyAccount extends StatelessWidget {
  const HeaderMyAccount({
    Key key,
    @required this.phoneHeigth,
  }) : super(key: key);

  final double phoneHeigth;

  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    return Positioned(
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
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    image: DecorationImage(
                      image: NetworkImage(bloc.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  bloc.firstName + ' ' + bloc.lastName,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  bloc.userEmail,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

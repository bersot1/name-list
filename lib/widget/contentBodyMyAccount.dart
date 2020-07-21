import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/detailsList.dart';
import 'package:nome_na_lista/model/listModel.dart';

class ContentBodyMyAccount extends StatelessWidget {
  final List<ListaModel> listas;

  const ContentBodyMyAccount({
    Key key,
    @required this.listas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listas.length > 0
        ? ListView.builder(
            itemCount: listas.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailsList(
                      idList: listas[index].id,
                    );
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            listas[index].name,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Código: " + listas[index].codigo,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text("Você ainda não tem listas criadas"),
          );
  }
}

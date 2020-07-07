import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  String _codList = "";

  Future<String> _showSearchList(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(
            decoration: InputDecoration(labelText: "Pesquisar Código:"),
            controller: customController,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(customController.text.toString());
              },
              elevation: 5.0,
              child: Text("Pesquisar"),
            )
          ],
        );
      },
    );
  }

  Future<String> _showDialogAccessList(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("MANSAO X AIRSOFT"),
          content: TextFormField(
            decoration: InputDecoration(labelText: "Senha da Lista"),
            controller: customController,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(customController.text.toString());
              },
              elevation: 5.0,
              child: Text("Entrar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSearchList(context).then((value) {
            if (value.length > 0) {
              _showDialogAccessList(context);
            }
          });
        },
        child: Icon(Icons.search),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("LISTA MANSAO X ARISOFT"),
                        Text("DATE"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        NLButton(
                            title: "Add na lista",
                            icon: Icon(Icons.add),
                            color: Colors.green,
                            func: () {}),
                        NLButton(
                          title: "Remover",
                          icon: Icon(Icons.remove),
                          color: Colors.red,
                          func: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 80,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Nome do Fulano" + index.toString()),
                        subtitle: Text("Email@lucas.com.br"),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NLButton extends StatelessWidget {
  final MaterialColor color;
  final String title;
  final Icon icon;
  final Function func;

  NLButton({
    @required this.color,
    @required this.title,
    @required this.icon,
    @required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: FlatButton(
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[icon, Text(title)],
        ),
      ),
    );
  }
}

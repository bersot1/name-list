import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/homePage.dart';
import 'package:nome_na_lista/UI/login.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Guarda na memoria
      providers: [
        ChangeNotifierProvider<InfoUserBloc>.value(
          value: InfoUserBloc(),
        ),
      ],
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context);

    return MaterialApp(
      title: 'Nome na Lista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: bloc.id == "" ? LoginPage() : TabsPage(),
      home: Login(),
    );
  }
}

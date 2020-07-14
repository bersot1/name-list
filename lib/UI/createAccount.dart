import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/homePage.dart';
import 'package:nome_na_lista/UI/loginPage.dart';
import 'package:nome_na_lista/UI/recouverAccount.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:nome_na_lista/model/userModel.dart';

import 'dart:convert' as JSON;

import 'package:nome_na_lista/repository/userRepository.dart';
import 'package:nome_na_lista/widget/dialogs.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final UserRepository _userRepository = new UserRepository();

  String _firstName;
  String _lastName;
  String _email;
  String _pass;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Primeiro Nome'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo Obrigatório';
        }
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Último Nome'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo Obrigatório';
        }
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-mail'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Por favor, insira um e-mail válido';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPass() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Senha"),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty)
          return "Campo Obrigatório";
        else if (value.length <= 8)
          return "Senha não pode ter menos de 8 caracteres";
      },
      onSaved: (String value) {
        _pass = value;
      },
    );
  }

  _insertUser(UserModel user) {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    _userRepository.createUser(user).then((value) {
      bloc.firstName = value.fristName;
      bloc.lastName = value.lastName;
      bloc.userEmail = value.email;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return TabsPage();
          },
        ),
      );
    });
  }

  _verifyEmail(UserModel user) {
    _userRepository.getUserByEmail(user.email).then((value) {
      if (value.email == user.email) {
        return showDialog(
          context: context,
          builder: (_) => BstageDialog(
            context: context,
            title: 'Email já cadastrado',
            subTitle: 'Entre ou recupere sua conta.',
            image:
                "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
            textButtonOK: "Entrar",
            textButtonCancel: "Recuperar Conta",
            funcButtonCancel: () {
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RecoverAccountPage();
                  },
                ),
              );
            },
            funcButtonOk: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
          ),
        );
      } else {
        _insertUser(user);
      }
    });
  }

  // final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildLastName(),
              _buildEmail(),
              _buildPass(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text("Cadastrar"),
                onPressed: () {
                  if (!_formKey.currentState.validate()) return;

                  _formKey.currentState.save();

                  print(_firstName);

                  var newUser = UserModel(
                      fristName: _firstName,
                      lastName: _lastName,
                      email: _email,
                      idFacebook: "",
                      phone: "",
                      password: _pass);

                  _verifyEmail(newUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo
  // repositorio
  // ver se existe
  // logica cadastrar login
  // _logInWithFacebook() async {
  //   final result = await facebookLogin.logInWithReadPermissions(['email']);
  //   // final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
  //   // final PerfilRepository _perfilRepository = new PerfilRepository();

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final token = result.accessToken.token;
  //       Response response = await Dio().get(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture.width(500).height(500),email&access_token=${token}');
  //       final profile = JSON.jsonDecode(response.data);

  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       setState(() => print('ERROR =  cancelledByUser'));
  //       break;
  //     case FacebookLoginStatus.error:
  //       setState(() => print('ERROR - ERROR'));
  //       break;
  //   }
  // }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nome_na_lista/UI/createAccount.dart';
import 'package:nome_na_lista/UI/homePage.dart';
import 'package:nome_na_lista/UI/recouverAccount.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/model/userModel.dart';

import 'dart:convert' as JSON;

import 'package:nome_na_lista/repository/userRepository.dart';
import 'package:nome_na_lista/widget/dialogs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final UserRepository _userRepository = new UserRepository();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  GoogleSignIn _googleSignIn2 = new GoogleSignIn(scopes: ['email']);

  String _email;
  String _pass;

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
        if (value.isEmpty) return "Campo Obrigatório";
      },
      onSaved: (String value) {
        _pass = value;
      },
    );
  }

  Future<void> handleSigninGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;
  }

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      _googleSignIn.signOut();
    });
  }

  _logInWithGoogle2() async {
    try {
      await _googleSignIn2.signIn();
    } catch (e) {
      print(e);
    }
  }

  // final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildEmail(),
              _buildPass(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text("Entrar"),
                onPressed: () {
                  if (!_formKey.currentState.validate()) return;

                  _formKey.currentState.save();

                  _userRepository.getUserByEmail(_email).then(
                    (value) {
                      if (value.email == _email && value.password == _pass) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return TabsPage();
                            },
                          ),
                        );
                      } else {
                        print("senha inválida");
                        _pass = "";
                        _email = "";

                        return showDialog(
                          context: context,
                          builder: (_) => BstageDialog(
                            context: context,
                            title: 'Email ou Senha Inválidos',
                            subTitle: 'Tente novamente ou recupere sua conta',
                            image:
                                "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                            textButtonOK: "Recuperar Conta",
                            textButtonCancel: "Tentar novamente",
                            funcButtonCancel: () {
                              return Navigator.pop(context);
                            },
                            funcButtonOk: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RecoverAccountPage();
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              RaisedButton(
                child: Text("Cadastre-se"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CreateAccountPage();
                  }));
                },
              ),
              RaisedButton(
                child: Text("Login with Google"),
                onPressed: () {
                  _logInWithGoogle2();
                },
              )
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

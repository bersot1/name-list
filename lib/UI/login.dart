import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/tabs.dart';
import 'package:nome_na_lista/bloc/infoUserbloc.dart';
import 'package:nome_na_lista/controllers/loginController.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/repository/userRepository.dart';
import 'package:nome_na_lista/widget/busy.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = new LoginController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserRepository _userRepository = new UserRepository();

  var busy = false;

  handleSignIn() {
    final InfoUserBloc bloc = Provider.of<InfoUserBloc>(context, listen: false);
    setState(() {
      busy = true;
    });
    controller.login().then((data) {
      var nameSplit = data.name.split(' ');
      bloc.firstName = nameSplit[0];
      bloc.lastName = nameSplit[1];
      bloc.userEmail = data.email;
      bloc.photo = data.picture;
      bloc.externalId = data.uid;

      var newUser = new UserModel(
        fristName: bloc.firstName,
        lastName: bloc.lastName,
        email: bloc.userEmail,
        photo: bloc.photo,
        externalId: bloc.externalId,
      );

      _userRepository.createUser(newUser).then((value) {
        bloc.id = value.id;
        onSuccess();
      });
    }).catchError((err) {
      onError();
    }).whenComplete(() {
      onComplete();
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TabsPage(
          paramIndex: 0,
        ),
      ),
    );
  }

  onError() {
    var snackbar = new SnackBar(content: new Text("Falha no login"));
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  onComplete() {}

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xff4f5b66),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Busy(
            busy: busy,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: phoneHeight / 6,
                ),
                Container(
                  width: double.infinity,
                  height: phoneHeight / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: phoneWidht / 2.5,
                        height: phoneWidht / 2.5,
                        child: Image.asset("assets/logo/logo.png"),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: handleSignIn,
                        child: Container(
                          width: phoneWidht / 1.5,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/icon/google.png"))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Login com Google",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "By Berso.aio",
                  style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

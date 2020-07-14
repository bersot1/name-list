import 'package:flutter/widgets.dart';

class InfoUserBloc extends ChangeNotifier {
  String firstName;
  String lastName;
  String userEmail;
  String phone;

  logOut() {
    this.firstName = "";
    this.lastName = "";
    this.userEmail = "";
    this.phone = "";
    notifyListeners();
  }
}

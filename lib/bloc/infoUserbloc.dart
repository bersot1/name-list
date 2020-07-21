import 'package:flutter/widgets.dart';
import 'package:nome_na_lista/model/allMyListsModel.dart';
import 'package:nome_na_lista/model/userModel.dart';
import 'package:nome_na_lista/model/usersListaModel.dart';

class InfoUserBloc extends ChangeNotifier {
  String id;
  String firstName;
  String lastName;
  String userEmail;
  String photo;
  String externalId;

  List<UserModel> usersOfList;
  List<MyAllListsModel> allMyLists;

  addCompleteValueinList(List<UserModel> listModel) {
    this.usersOfList = listModel;
    notifyListeners();
  }

  addUserInList(UserModel newUser) {
    this.usersOfList.add(newUser);
    notifyListeners();
  }

  removeUserInList() {
    this.usersOfList.removeLast();
    notifyListeners();
  }

  sigOut() {
    this.id = "";
    this.firstName = "";
    this.lastName = "";
    this.userEmail = "";
    this.photo = "";
    this.usersOfList = [];
    notifyListeners();
  }
}

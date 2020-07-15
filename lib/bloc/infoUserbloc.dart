import 'package:flutter/widgets.dart';
import 'package:nome_na_lista/model/usersListaModel.dart';

class InfoUserBloc extends ChangeNotifier {
  String id = "9647311D-9D08-43AB-B0CA-A8B2A1DC4F22";
  String firstName = "Lucas";
  String lastName = "Bersot";
  String userEmail = "lucasbmarinho9@gmail.com";
  String phone = "274999569432";

  List<UsersListModel> usersOfList;

  logOut() {
    this.firstName = "";
    this.lastName = "";
    this.userEmail = "";
    this.phone = "";
    notifyListeners();
  }

  addCompleteValueinList(List<UsersListModel> listModel) {
    this.usersOfList = listModel;
    notifyListeners();
  }

  addUserInList(UsersListModel newUser) {
    this.usersOfList.add(newUser);
    notifyListeners();
  }

  removeUserInList() {
    this.usersOfList.removeLast();
    notifyListeners();
  }
}

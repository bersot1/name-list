import 'package:dio/dio.dart';
import 'package:nome_na_lista/model/createUserList.dart';
import 'package:nome_na_lista/model/deleteUserList.dart';
import '../config.dart';

class UserListaRepository {
  Future<CreateUserListaModel> insertUserInList(
      CreateUserListaModel data) async {
    var url = Settings.apiUrlv1 + "userLista";

    Response response = await Dio().post(url, data: data);
    return CreateUserListaModel.fromJson(response.data);
  }

  Future deleteUserList(DeleteUserListaModel userList) async {
    var url = Settings.apiUrlv1 + "userLista";

    try {
      Response response = await Dio().delete(url, data: userList);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}

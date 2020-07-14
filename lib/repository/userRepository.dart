import 'package:nome_na_lista/model/userModel.dart';

import 'package:dio/dio.dart';
import '../config.dart';

class UserRepository {
  Future<UserModel> createUser(UserModel perfil) async {
    var url = Settings.apiUrlv1 + "user";

    try {
      Response response = await Dio().post(url, data: perfil);
      return UserModel.fromJson(response.data);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getUserByEmail(String email) async {
    var url = Settings.apiUrlv1 + "user/getByEmail/" + email;

    try {
      Response response = await Dio().get(url);

      return UserModel.fromJson(response.data);
    } catch (e) {
      return e;
    }
  }
}

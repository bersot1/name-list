import 'package:nome_na_lista/model/allMyListsModel.dart';
import 'package:nome_na_lista/model/deleteListaModel.dart';
import 'package:nome_na_lista/model/listCreateModel.dart';
import 'package:nome_na_lista/model/listModel.dart';

import 'package:dio/dio.dart';
import '../config.dart';

class ListaRepository {
  Future<dynamic> createList(CreateListaModel lista) async {
    var url = Settings.apiUrlv1 + "lista";

    Response response = await Dio().post(url, data: lista);

    if (response.data["sucess"] == false) {
      return "erro";
    }
    return ListaModel.fromJson(response.data["data"]);
  }

  Future<ListaModel> getByList(String codigo) async {
    var url = Settings.apiUrlv1 + "lista/GetByCodigo/" + codigo;

    Response response = await Dio().get(url);
    return ListaModel.fromJson(response.data);
  }

  Future<List<ListaModel>> getAllMyLists(String id) async {
    var url = Settings.apiUrlv1 + "lista/GetAllByIdCriator/" + id;

    try {
      Response response = await Dio().get(url);

      return (response.data as List)
          .map((e) => ListaModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteLista(DeleteListaModel lista) async {
    var url = Settings.apiUrlv1 + "lista";

    Response response = await Dio().delete(url, data: lista);
    return response.data;
  }
}

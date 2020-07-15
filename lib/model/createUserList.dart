class CreateUserListaModel {
  DateTime register;
  String idLista;
  String idUser;

  CreateUserListaModel({this.register, this.idLista, this.idUser});

  CreateUserListaModel.fromJson(Map<String, dynamic> json) {
    register = DateTime.parse(json['register']);
    idLista = json['idLista'];
    idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['register'] = this.register.toString().substring(0, 11);
    data['idLista'] = this.idLista;
    data['idUser'] = this.idUser;
    return data;
  }
}

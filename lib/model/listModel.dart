class ListaModel {
  String name;
  DateTime start;
  String description;
  String codigo;
  String password;
  String criatorId;
  Null userLists;
  String id;

  ListaModel(
      {this.name,
      this.start,
      this.description,
      this.codigo,
      this.password,
      this.criatorId,
      this.userLists,
      this.id});

  ListaModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    start = DateTime.parse(json['start']);
    description = json['description'];
    codigo = json['codigo'];
    password = json['password'];
    criatorId = json['criatorId'];
    userLists = json['userLists'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['start'] = this.start.toString();
    data['description'] = this.description;
    data['codigo'] = this.codigo;
    data['password'] = this.password;
    data['criatorId'] = this.criatorId;
    data['userLists'] = this.userLists;
    data['id'] = this.id;
    return data;
  }
}

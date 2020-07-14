class ListaModel {
  String name;
  DateTime start;
  String description;
  String codigo;
  String password;
  String criatorId;
  String id;

  ListaModel(
      {this.name,
      this.start,
      this.description,
      this.codigo,
      this.password,
      this.criatorId,
      this.id});

  ListaModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    start = DateTime.parse(json['start']);
    description = json['description'];
    codigo = json['codigo'];
    password = json['password'];
    criatorId = json['criatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['start'] = this.start.toString().substring(0, 11);
    data['description'] = this.description;
    data['codigo'] = this.codigo;
    data['password'] = this.password;
    data['criatorId'] = this.criatorId;
    data['id'] = this.id;
    return data;
  }
}

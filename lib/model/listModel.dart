class ListaModel {
  String id;
  String name;
  DateTime start;
  String description;
  String criatorId;
  String codigo;
  String password;

  ListaModel(
      {this.id,
      this.name,
      this.start,
      this.description,
      this.criatorId,
      this.codigo,
      this.password});

  ListaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    start = DateTime.parse(json['start']);
    description = json['description'];
    criatorId = json['criatorId'];
    codigo = json['codigo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start'] = this.start.toString();
    data['description'] = this.description;
    data['criatorId'] = this.criatorId;
    data['codigo'] = this.codigo;
    data['password'] = this.password;
    return data;
  }
}

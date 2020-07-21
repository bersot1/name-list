class CreateListaModel {
  String name;
  DateTime start;
  String description;
  String criadorId;
  String pass;

  CreateListaModel(
      {this.name, this.start, this.description, this.criadorId, this.pass});

  CreateListaModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    start = DateTime.parse(json['start']);
    description = json['description'];
    criadorId = json['criadorId'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['start'] = this.start.toString().substring(0, 11);
    data['description'] = this.description;
    data['criadorId'] = this.criadorId;
    data['pass'] = this.pass;
    return data;
  }
}

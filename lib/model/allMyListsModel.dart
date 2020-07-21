class MyAllListsModel {
  String idLista;
  String nomeDaLista;
  int total;

  MyAllListsModel({this.idLista, this.nomeDaLista, this.total});

  MyAllListsModel.fromJson(Map<String, dynamic> json) {
    idLista = json['IdLista'];
    nomeDaLista = json['NomeDaLista'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdLista'] = this.idLista;
    data['NomeDaLista'] = this.nomeDaLista;
    data['Total'] = this.total;
    return data;
  }
}

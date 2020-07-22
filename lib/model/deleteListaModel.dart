class DeleteListaModel {
  String idList;

  DeleteListaModel({this.idList});

  DeleteListaModel.fromJson(Map<String, dynamic> json) {
    idList = json['idList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idList'] = this.idList;
    return data;
  }
}

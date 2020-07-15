class DeleteUserListaModel {
  String listId;
  String userId;

  DeleteUserListaModel({this.listId, this.userId});

  DeleteUserListaModel.fromJson(Map<String, dynamic> json) {
    listId = json['listId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listId'] = this.listId;
    data['userId'] = this.userId;
    return data;
  }
}

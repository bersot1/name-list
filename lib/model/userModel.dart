class UserModel {
  String id;
  String fristName;
  String lastName;
  String email;
  String photo;
  String externalId;

  UserModel(
      {this.id,
      this.fristName,
      this.lastName,
      this.email,
      this.photo,
      this.externalId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fristName = json['fristName'];
    lastName = json['lastName'];
    email = json['email'];
    photo = json['photo'];
    externalId = json['externalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fristName'] = this.fristName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['externalId'] = this.externalId;
    return data;
  }
}

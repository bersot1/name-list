class UserModel {
  String id;
  String fristName;
  String lastName;
  String email;
  String phone;
  String idFacebook;
  String password;

  UserModel(
      {this.fristName,
      this.lastName,
      this.email,
      this.phone,
      this.idFacebook,
      this.password,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    fristName = json['fristName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    idFacebook = json['idFacebook'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fristName'] = this.fristName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['idFacebook'] = this.idFacebook;
    data['password'] = this.password;
    data['id'] = this.id;

    return data;
  }
}

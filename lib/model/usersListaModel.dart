class UsersListModel {
  String id;
  String fristName;
  String lastName;
  String phone;
  String email;
  String idFacebook;

  UsersListModel(
      {this.id,
      this.fristName,
      this.lastName,
      this.phone,
      this.email,
      this.idFacebook});

  UsersListModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fristName = json['FristName'];
    lastName = json['LastName'];
    phone = json['Phone'];
    email = json['Email'];
    idFacebook = json['IdFacebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FristName'] = this.fristName;
    data['LastName'] = this.lastName;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['IdFacebook'] = this.idFacebook;
    return data;
  }
}

import 'package:pizo/resources/constants.dart';

Constants cons = new Constants();

class Profile {
  String id, name, email, balance, img;
  var status, group_id, pics_uploaded, phone;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.balance,
      this.img,
      this.status,
      this.group_id,
      this.pics_uploaded,
      this.phone});

  factory Profile.fromJson(Map<String, dynamic> parsedJson) {
    return Profile(
        img: cons.domain + parsedJson['img'].toString(),
        name: parsedJson['name'],
        email: parsedJson['email'],
        balance: parsedJson['balance'],
        id: parsedJson['owner_name'],
        status: parsedJson['status'],
        group_id: parsedJson['group_id'],
        pics_uploaded: parsedJson['pics_uploaded'],
        phone: parsedJson['phone']);
  }

  getID() {
    return id;
  }

  getName() {
    return name;
  }

  getEmail() {
    return email;
  }

  getBalance() {
    return balance;
  }

  getStatus() {
    return status;
  }

  getGroupID() {
    return group_id;
  }

  getPicsUploaded() {
    return pics_uploaded;
  }

  getImg() {
    return img;
  }

  getPhone() {
    return phone;
  }
}

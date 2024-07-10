import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String phone;

  User(this.name, this.phone);

  Map<String, String> toJson(){
    return {
      "name": name,
      "phone": phone,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    Map<String, dynamic> data = snapshot.data()!;
    return User(data["name"], data["phone"]);
  }
}
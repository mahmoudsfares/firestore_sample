import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sample/entity/user.dart';

class ShowUsersViewModel {
  final StreamController<List<User>> _controller = StreamController();
  Stream<List<User>> get usersStream => _controller.stream;

  Future<void> getUsers() async {
    final FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await database.collection("Users").get();
    List<User> users = snapshot.docs.map((e) => User.fromSnapshot(e)).toList();
    _controller.add(users);
  }
}
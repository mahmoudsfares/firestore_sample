import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sample/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUserPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firestore Sample"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: storeInDatabase,
                child: const Text("Store in database"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/showUsers'),
                child: const Text("Show existing users"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void storeInDatabase() {
    User user = User(nameController.text, phoneController.text);
    final FirebaseFirestore database = FirebaseFirestore.instance;
    database
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Fluttertoast.showToast(msg: "Added Successfully"))
        .catchError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }
}

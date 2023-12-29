import 'package:crudsqlite/model/user.dart';
import 'package:crudsqlite/services/user_service.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();
  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add user"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter name',
                    labelText: "Name",
                    errorText:
                        validateName ? 'Name value can\'t be empty' : null),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: userContactController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter contact',
                    labelText: "Contact",
                    errorText:
                        validateName ? 'Contact value can\'t be empty' : null),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: userDescriptionController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter description',
                    labelText: "Description",
                    errorText: validateName
                        ? 'Description value can\'t be empty'
                        : null),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          userNameController.text.isEmpty
                              ? validateName = true
                              : false;

                          userContactController.text.isEmpty
                              ? validateContact = true
                              : false;

                          userDescriptionController.text.isEmpty
                              ? validateDescription = true
                              : false;
                        });

                        if (validateName == false &&
                            validateContact == false &&
                            validateDescription == false) {
                          print("calling");
                          var user = User();
                          user.name = userNameController.text;
                          user.contact = userContactController.text;
                          user.description = userDescriptionController.text;

                          var result = userService.saveUser(user);
                          print(result);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text("Save Details")),
                  SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 15)),
                    child: const Text("Clear Details"),
                    onPressed: () {
                      userNameController.text = "";
                      userContactController.text = "";
                      userDescriptionController.text = "";
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

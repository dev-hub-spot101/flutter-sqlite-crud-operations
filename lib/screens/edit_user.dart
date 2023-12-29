import 'package:crudsqlite/model/user.dart';
import 'package:crudsqlite/services/user_service.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();
  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;
  final userService = UserService();

  @override
  void initState() {
    setState(() {
      userNameController.text = widget.user.name ?? "";
      userContactController.text = widget.user.contact ?? "";
      userDescriptionController.text = widget.user.description ?? "";
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Edit user"),
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
                          user.id = widget.user.id;
                          user.name = userNameController.text;
                          user.contact = userContactController.text;
                          user.description = userDescriptionController.text;

                          var result = userService.updateUser(user);
                          print(result);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text("Update Details")),
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

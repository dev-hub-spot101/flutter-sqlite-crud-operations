import 'package:crudsqlite/model/user.dart';
import 'package:crudsqlite/screens/add_user.dart';
import 'package:crudsqlite/screens/edit_user.dart';
import 'package:crudsqlite/screens/view_user.dart';
import 'package:crudsqlite/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> userList = <User>[];
  final userService = UserService();

  getAllUserDetails() async {
    var users = await userService.readAllUsers();
    userList = <User>[];
    if (users == null) {
      setState(() {
        userList = [];
      });
    } else {
      users.forEach((user) {
        setState(() {
          var userModel = User();
          userModel.id = user['id'];
          userModel.name = user['name'];
          userModel.contact = user['contact'];
          userModel.description = user['description'];
          userList.add(userModel);
        });
      });
    }
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "CRUD List Sqlite",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewUser(
                              user: userList[index],
                            ))).then((data) => {getAllUserDetails()});
              },
              leading: const Icon(Icons.person),
              title: Text(userList[index].name ?? ""),
              subtitle: Text(userList[index].contact ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditUser(
                                      user: userList[index],
                                    ))).then((data) => {getAllUserDetails()});
                      },
                      icon: Icon(Icons.edit, color: Colors.blue)),
                  IconButton(
                      onPressed: () {
                        deleteFormDialog(context, userList[index].id);
                      },
                      icon: Icon(Icons.delete, color: Colors.red))
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((data) => {getAllUserDetails()});
          ;
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text("Are you sure to delete!",
                style: TextStyle(color: Colors.teal, fontSize: 20)),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(fontSize: 15)),
                child: const Text("Delete"),
                onPressed: () async {
                  var result = await userService.deleteUser(userId);
                  if (result != null) {
                    Navigator.pop(context);
                    getAllUserDetails();
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 15)),
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}

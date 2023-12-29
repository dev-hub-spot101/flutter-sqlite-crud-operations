import 'package:crudsqlite/model/user.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  final User user;
  const ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("View user"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    widget.user.name ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Contact",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    widget.user.contact ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user.description ?? "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

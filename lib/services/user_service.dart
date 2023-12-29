import 'dart:async';

import 'package:crudsqlite/db/repository.dart';
import 'package:crudsqlite/model/user.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  //save user
  saveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Read by id
  readUserById(id) async {
    return await _repository.readDataById('users', id);
  }

  //edit Users
  updateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  //delete Users
  deleteUser(userId) async {
    return await _repository.deleteData('users', userId);
  }
}

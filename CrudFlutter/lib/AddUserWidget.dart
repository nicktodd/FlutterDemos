import 'package:flutter/material.dart';
import 'UsernameRepository.dart';
import 'User.dart';
import 'main.dart';

class AddUserWidget extends StatelessWidget {

  TextEditingController _controller;
  User selectedUser;

  AddUserWidget({this.selectedUser});

  String userName = "";
  @override
  Widget build(BuildContext context) {
    _controller = new TextEditingController(text: (selectedUser!=null)?selectedUser.name:"");

    UserContainerWidgetState parent = context.ancestorStateOfType(const TypeMatcher<UserContainerWidgetState>(),);

    return Scaffold(
      appBar: AppBar(
        title: (selectedUser==null)? Text("Add User") : Text("Edit User"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          TextField(
            controller: _controller,
            onChanged: (text) {
              userName = text;
            },
          ),

          RaisedButton(
            onPressed: () {
              Future<User> futureUser;
              if (selectedUser == null) {
                futureUser = UsernameRepository().postUser(
                    userName);
              }
              else {
                selectedUser.name = userName;
                futureUser = UsernameRepository().editUser(selectedUser);
              }
              futureUser.whenComplete(() =>
                Navigator.pop(context)
              );
            },
            child: (selectedUser==null)? Text("Submit New User") : Text("Submit Edit"),
          ),
        ]),
      ),
    );
  }
}

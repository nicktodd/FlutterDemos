import 'package:flutter/material.dart';
import 'UsernameRepository.dart';
import 'User.dart';
import 'AddUserWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD REST API Example',
      home: UserContainerWidget(),
    );
  }
}

class UserContainerWidget extends StatefulWidget {
  @override
  UserContainerWidgetState createState() => UserContainerWidgetState();
}

class UserContainerWidgetState extends State<UserContainerWidget> {
  Future<List<User>> users;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  User selectedUser;
  /*@override
  void initState() {
    super.initState();
    //users = UsernameRepository().fetchUsers();
  }*/

  @override
  Widget build(BuildContext context) {
    users = UsernameRepository().fetchUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('REST CRUD Example'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addUserBtnPress,
          tooltip: "Add user",
          child: Icon(Icons.add)),
      body: _buildUserList(),
    );
  }

  _updateUserBtnPress(User user) {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddUserWidget(selectedUser: user)),
      );
    });
  }

  _addUserBtnPress() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddUserWidget()),
      );
    });
  }

  Widget _buildUserList() {
    return FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data.length * 2,
                itemBuilder: (BuildContext _context, int i) {
                  if (i.isOdd) {
                    return Divider();
                  }

                  final int index = i ~/ 2;
                  if (snapshot.data.length > index)
                    return _buildRow(snapshot.data[index], snapshot.data);
                });
          }
        });
  }

  Widget _buildRow(User user, List<User> users) {
    return Dismissible(
      key: Key(user.id.toString()),
      onDismissed: (direction) {
        setState(() {
          users.remove(user);
          UsernameRepository().deleteUser(user);
        });
        Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("${user.name} dismissed")));

      },

      background: Container(color: Colors.lightBlue),
      child: ListTile(
        title: Text(
          user.toString(),
          style: _biggerFont,
        ),
        trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _updateUserBtnPress(user);
            }),
      ),
    );



    /*return ListTile(
      title: Text(
        user.toString(),
        style: _biggerFont,
      ),
      trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _updateUserBtnPress(user);
          }),
    );*/
  }
}

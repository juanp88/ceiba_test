import 'package:flutter/material.dart';
import 'package:users_test/config/consts.dart';
import 'package:users_test/models/user_model.dart';
import 'package:users_test/view_model/user_view_model.dart';
import 'package:users_test/widgets/user_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var isLoading = false;
  late Future<bool> isEmpty;
  List allUsers = [];

  TextEditingController controlador = TextEditingController();
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    allUsers = userViewModel.userListModel;

    if (allUsers.isEmpty) {
      userViewModel.insertUser();
      allUsers = userViewModel.userListModel;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text('Api to sqlite'),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).devicePixelRatio * 110,
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Ingrese el nombre de usuario"),
                      controller: controlador,
                      onChanged: (value) {
                        setState(() {
                          searchInput = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Expanded(child: _buildUsersListView(userViewModel))
                ],
              ));
  }

  Widget _buildUsersListView(UserViewModel userViewModel) {
    if (userViewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final usersFiltered = allUsers.where((user) {
      final nameLower = user.name.toLowerCase();
      final searchLower = searchInput.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    return (searchInput.isNotEmpty && usersFiltered.isEmpty)
        ? Container(
            child: Text('No existe el usuario'),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              User user = (searchInput.isNotEmpty
                  ? usersFiltered[index]
                  : allUsers[index]);
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'userPost', arguments: user);
                },
                child: userCard(user.name.toString(), user.email.toString(),
                    user.phone.toString()),
              );
            },
            separatorBuilder: (context, index) => Container(
                  height: 5,
                ),
            itemCount:
                searchInput.isEmpty ? allUsers.length : usersFiltered.length);
  }
}

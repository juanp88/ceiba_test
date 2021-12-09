import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users_test/config/consts.dart';

Widget userCard(String name, String email, String phone) {
  return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: Column(children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
          title: Text(
            name,
            style: cardTitle,
          ),
          subtitle: Column(
            children: [
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Icon(
                    Icons.phone,
                    color: iconsColors,
                    size: cardIconSize,
                  ),
                  title: Text(
                    phone,
                    style: cardSubText,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListTile(
                  //tileColor: Colors.yellow,
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Icon(
                    Icons.mail,
                    color: iconsColors,
                    size: cardIconSize,
                  ),
                  title: Text(
                    email,
                    style: cardSubText,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                  child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Ver publicaciones'))),
            ],
          ),
        )
      ]));
}

import 'package:flutter/material.dart';

Widget userListView(context, snapshot) {
  return ListView.separated(
    separatorBuilder: (context, index) => const Divider(
      color: Colors.black12,
    ),
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("${snapshot.data[index].name}"),
        subtitle: Text('${snapshot.data[index].phone}'),
      );
    },
  );
}

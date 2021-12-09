import 'package:flutter/material.dart';
import 'package:users_test/config/consts.dart';
import 'package:users_test/models/post_model.dart';
import 'package:users_test/models/user_model.dart';
import 'package:users_test/services/api_service.dart';

class UserPost extends StatefulWidget {
  UserPost({Key? key}) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text(
            routeData.name.toString(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Expanded(
          child: Column(
            children: [
              Text('e-Mail: ' + routeData.email.toString()),
              Text('Phone : ' + routeData.phone.toString()),
              Container(
                height: 10,
              ),
              const Text("Posts: "),
              postsListview(routeData.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget postsListview(id) {
    return FutureBuilder(
        future: UserApiProvider().getUserPosts(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var posts = snapshot.data.response;
            return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40,
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text("${posts[index].body}"),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black12,
                    ),
                itemCount: posts.length);
          }
        });
  }
}

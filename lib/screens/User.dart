import 'package:flutter/material.dart';
import '../api/controller/api_controller.dart';
import '../api/model/userController.dart';

class User extends StatefulWidget {
  late int id;
  User(this.id);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<UserController?>(
        future: ApiController().GetOneUser(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            UserController? US = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Colors.blue[100],
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            '${US?.id}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      title: Text(
                        '${US?.name}',
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        '${US?.username}'
                        '${US?.email}'
                        '${US?.address}'
                        '${US?.phone}'
                        '${US?.website}'
                        '${US?.company}',
                        maxLines: 6,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

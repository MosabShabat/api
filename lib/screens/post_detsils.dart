import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/controller/api_controller.dart';
import '../api/model/post.dart';
import 'User.dart';

class PostDetails extends StatefulWidget {
  late int id;
  PostDetails(this.id);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Post?>(
        future: ApiController().getOnePost(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Post? p = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Colors.blue[100],
                    child: ListTile(
                      onTap: () {
                        Get.to(() => User(p.id!));
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            '${p!.id}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      title: Text(
                        p.title!,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        p.body!,
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () async {
                  print(await ApiController().getFamilyMembers(page: "1",lang: 'ar',offset: "1",row: "5",pc:'0/372081' ));
                }, child: Text("clickHere"))
        
              ],
            );

          }
        },
      ),
    );
  }
}

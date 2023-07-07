import 'package:api/api/controller/api_controller.dart';
import 'package:api/api/model/post.dart';
import 'package:api/screens/auth/login_screen.dart';
import 'package:api/screens/images/get_image.dart';
import 'package:api/screens/post_detsils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/controller/Image_api_controller.dart';
import '../api/model/api_response.dart';
import '../api/model/image.dart';
import '../api/model/student_image.dart';
import '../controller/auth_getx_controller.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthGetxController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => GetImage());
              },
              icon: Icon(Icons.image)),
          IconButton(
              onPressed: () async {
                await _logout();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<Imagee>>(
        future: ImageApiController().getImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Imagee p = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        minVerticalPadding: 30,
                        title: Text(
                          '${p.info!}',
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(p.image!),
                        ),
                        // onTap: () {
                        //   Get.to(() => PostDetails(p.id!));
                        // },
                        // leading: Container(
                        //   width: 40,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       color: Colors.white),
                        //   child: Center(
                        //     child: Text(
                        //       '${p.id}',
                        //       style: const TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                        // title: Text(
                        //   p.title!,
                        //   maxLines: 1,
                        //   style: const TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black),
                        // ),
                        // subtitle: Text(
                        //   p.body!,
                        //   maxLines: 3,
                        //   style: const TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black),
                        // ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("no data found"),
            );
          }
        },
      ),
    );
  }

  Future<void> _logout() async {
    APIResponse response = await AuthGetxController().logout();
    print(response.status);
    if (response.status!) {
      Get.off(() => LoginScreen());
    }
    Get.snackbar("message", response.message!,
        backgroundColor: response.status! ? Colors.green : Colors.red,
        colorText: Colors.white);
  }
}

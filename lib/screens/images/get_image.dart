import 'package:api/api/model/student_image.dart';
import 'package:api/controller/image_getx_controller.dart';
import 'package:api/screens/images/add_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetImage extends StatefulWidget {
  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  @override
  void initState() {
    Get.put(ImageGetXController()).getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddImage());
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: GetX<ImageGetXController>(
        init: ImageGetXController(),
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: controller.images.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.33),
                  itemBuilder: (context, index) {
                    StudentImage img = controller.images[index];
                    return Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FadeInImage(
                              placeholder: const NetworkImage(
                                  "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
                              image: NetworkImage(
                                "${img.imageUrl}",
                              )),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}








/**
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Get.to(()=>AddImage());
        }, icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<StudentImage>>(
        future: StudentApiController().getStudentImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              itemCount: snapshot.data?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 2),
              itemBuilder: (context, index) {
                StudentImage img = snapshot.data![index];
                return Stack(
                  children: [
                    FadeInImage(
                        placeholder: const NetworkImage(
                            "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
                        image: NetworkImage("${img.imageUrl}"))
                    // Image.network("${img.image}")
                    // Container(
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: NetworkImage("")
                    //     )
                    //   ),
                    // )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

 * 
 */
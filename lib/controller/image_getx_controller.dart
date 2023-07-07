import 'package:api/api/model/student_image.dart';
import 'package:get/get.dart';
import '../api/controller/sudent_api_controller.dart';
import '../api/model/ApiImageResplose.dart';

class ImageGetXController extends GetxController {
  RxList<StudentImage> images = <StudentImage>[].obs;
  RxBool isLoading = false.obs;
  getImage() async {
    isLoading.value = true;
    images.value = await StudentApiController().getStudentImage();
    isLoading.value = false;
  }

  addImage({path}) async {
    APIImageResponse? response = await StudentApiController().uploadImage(path);
    if (response != null) {
      print(response.status);
      if (response.status!) {
        images.add(response.object!);
        return true;
      }
    } else {
      return false;
    }
  }
}

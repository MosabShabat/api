import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/controller/sudent_api_controller.dart';
import '../api/model/api_response.dart';

class AuthGetxController extends GetxController {
  Future<bool> login({email, password}) async {
    APIResponse response =
        await StudentApiController().login(email: email, password: password);
    if (response.status!) {
      GetStorage().write("userName", response.object!.fullName!);
      GetStorage().write("token", response.object!.token!);
      return response.status!;
    } else
      return response.status!;
  }

  Future<APIResponse> register({email, password, full_name, gender}) async {
    APIResponse response = await StudentApiController().register(
        email: email, password: password, full_name: full_name, gender: gender);
    return response;
  }

  Future<APIResponse> forgetpassword({email}) async {
    APIResponse response =
        await StudentApiController().forgotPassword(email: email);
    return response;
  }

  Future<APIResponse> reset({email, code, password}) async {
    APIResponse response = await StudentApiController()
        .resetPassword(email: email, code: code, password: password);
    return response;
  }

  Future<APIResponse> logout() async {
    APIResponse response = await StudentApiController().logout();
    return response;

  }
}

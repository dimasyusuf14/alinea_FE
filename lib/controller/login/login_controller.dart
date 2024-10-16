import 'package:alinea/services/api_services.dart';
import 'package:alinea/utilities/api_constant.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var passController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var checkC = false.obs;

  var isHidden = false.obs;

  void login() async {
    Helper.loadingScreen();

    var requestBodyMap = {
      "email": emailController.value.text,
      "password": passController.value.text,
    };

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.login,
          type: APIMethod.post,
          requestBodyMap: requestBodyMap,
          withToken: false);

      if (data['status'] == 200) {
        Get.back();
        var token = data['data']['token'];
        final box = GetStorage();
        await box.write("token", token);
      } else {
        Get.back();
        Helper.setSnackbar('eror');
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar(e.toString());
      logPrint("ERR : ${e.toString()}");
    }
  }

  void signUp() {}
}

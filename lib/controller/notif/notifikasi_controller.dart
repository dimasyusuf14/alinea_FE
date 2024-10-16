import 'package:alinea/models/notif/notifikasi_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/utilities/api_constant.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:get/get.dart';

class NotifikasiController extends GetxController {
  var id = 0.obs;

  var detail = Rxn<NotifikasiModel>();
  var loadingDetail = DataLoad.done.obs;

//TABBAR
  var selectedIndex = 0.obs;
  List<String> listTab = [
    "notifikasi",
    'peringatan',
  ];

  @override
  void onInit() {
    id.value = Get.arguments;
    getDetailHome();
    super.onInit();
  }

  void getDetailHome() async {
    loadingDetail.value = DataLoad.loading;
    try {
      var data = await APIServices.api(
        endPoint: APIEndpoint.telik,
        type: APIMethod.get,
        param: "/$id",
      );
      if (data['data'] != null) {
        detail.value = NotifikasiModel.fromJson(data['data']);
        loadingDetail.value = DataLoad.done;
      } else {
        loadingDetail.value = DataLoad.failed;
      }
    } catch (e) {
      loadingDetail.value = DataLoad.failed;
      logPrint("ERROR : ${e.toString()}");
    }
  }
}

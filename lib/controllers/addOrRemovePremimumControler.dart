import 'package:get/get.dart';

class AddorRemoveController extends GetxController {
  var subscribedStatus = "Add to Premimum".obs;

  removetatus() {
    subscribedStatus.value = "remove from premium";
  }
}

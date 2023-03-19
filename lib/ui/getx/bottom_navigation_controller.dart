import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/getx/user_controller.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;
  UserController userController = Get.put(UserController());

  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      if (!userController.checkAuthState()) {
        return;
      }
    }
    selectedIndex = index;
    update();
  }
}

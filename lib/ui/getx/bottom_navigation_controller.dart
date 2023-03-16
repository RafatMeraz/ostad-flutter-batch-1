import 'package:get/get.dart';
import 'auth_controller.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;
  AuthController authController = Get.put(AuthController());

  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      if (!authController.checkAuthState()) {
        return;
      }
    }
    selectedIndex = index;
    update();
  }
}

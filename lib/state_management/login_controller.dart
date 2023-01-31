import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network_services/network_requester.dart';
import '../utils/user_data.dart';

class LoginController extends GetxController {
  bool loginInProgress = false;

  /// login
  Future<bool> loginWithEmailPassword(String email, String password) async {
    loginInProgress = true;
    update();
    final result = await NetworkRequester()
        .postRequest('https://task.teamrabbil.com/api/v1/login', {
      "email": email,
      "password": password,
    });
    print(result);
    loginInProgress = false;
    update();
    if (result['status'] == 'success') {
      final sharedPrefs = await SharedPreferences.getInstance();
      UserData.token = result['token'];
      UserData.firstName = result['data']['firstName'];
      UserData.lastName = result['data']['lastName'];
      UserData.email = result['data']['email'];
      UserData.phone = result['data']['mobile'];

      sharedPrefs.setString('email', result['data']['email']);
      sharedPrefs.setString('firstName', result['data']['firstName']);
      sharedPrefs.setString('phone', result['data']['mobile']);
      sharedPrefs.setString('lastName', result['data']['lastName']);
      sharedPrefs.setString('token', result['token']);

      return true;
    } else {
      return false;
    }
  }
}

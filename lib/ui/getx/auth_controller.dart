import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/data/models/read_profile_model.dart';
import 'package:ostad_flutter_batch_one/data/models/user_details.dart';
import 'package:ostad_flutter_batch_one/data/network_utils.dart';
import 'package:ostad_flutter_batch_one/data/urls.dart';
import 'package:ostad_flutter_batch_one/ui/getx/user_controller.dart';

class AuthController extends GetxController {
  bool authState = false;
  bool sendVerificationCodeToEmailInProgress = false;
  bool verifyOtpInProgress = false;
  UserController userController = Get.put(UserController());

  Future<bool> sendVerificationCodeToEmail(String email) async {
    sendVerificationCodeToEmailInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.sendOtpToEmail(email));
    sendVerificationCodeToEmailInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    verifyOtpInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.verifyOtp(email, otp));
    verifyOtpInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      await userController.saveUserToken(response['data']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readProfileDetails() async {
    verifyOtpInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.readProfileDetails);
    verifyOtpInProgress = false;
    if (response != null && response['msg'] == 'success') {
      ReadProfileModel readProfileModel = ReadProfileModel.fromJson(response);
      if ((readProfileModel.data?.length ?? 0) > 0) {
        ProfileData profileData = readProfileModel.data!.first;
        UserDetails userDetails = UserDetails(
            profileData.firstName ?? '',
            profileData.lastName ?? '',
            profileData.shippingAddress ?? '',
            profileData.email!,
            profileData.city ?? '',
            profileData.id!,
            profileData.mobile ?? '');
        userController.saveUserDetails(userDetails);
        return true;
      } else {
        update();
        return false;
      }
    } else {
      return false;
    }
  }
}
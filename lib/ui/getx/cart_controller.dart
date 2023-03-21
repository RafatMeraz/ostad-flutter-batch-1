import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/data/models/cart_list_model.dart';
import 'package:ostad_flutter_batch_one/data/network_utils.dart';
import 'package:ostad_flutter_batch_one/data/urls.dart';

class CartController extends GetxController {
  bool addToCartInProgress = false;
  bool getCartListInProgress = false;
  CartListModel cartListModel = CartListModel();

  Future<bool> addToCart(int productId, String size, String color) async {
    addToCartInProgress = true;
    update();
    final result = await NetworkUtils().postMethod(Urls.addToCartUrl, body: {
      "product_id": productId.toString(),
      "color": color,
      "size": size
    });
    addToCartInProgress = false;
    update();
    if (result != null && result['msg'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getCartList() async {
    getCartListInProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.getAllCartsUrl);
    getCartListInProgress = false;
    if (result != null && result['msg'] == 'success') {
      cartListModel = CartListModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
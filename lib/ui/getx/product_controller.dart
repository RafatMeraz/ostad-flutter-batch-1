import 'dart:developer';

import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/data/models/product_model.dart';
import 'package:ostad_flutter_batch_one/data/network_utils.dart';
import 'package:ostad_flutter_batch_one/data/urls.dart';

class ProductController extends GetxController {
  ProductModel popularProductModel = ProductModel();
  ProductModel specialProductModel = ProductModel();
  ProductModel newProductModel = ProductModel();
  ProductModel productByCategoryModel = ProductModel();

  bool popularInProgress = false;
  bool specialInProgress = false;
  bool newInProgress = false;
  bool productByCategoryInProgress = false;

  Future<bool> getPopularProducts() async {
    popularInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.productByRemarksUrl('popular'));
    popularInProgress = false;
    if (response != null && response['msg'] == 'success') {
      popularProductModel = ProductModel.fromJson(response);
      update();
      return true;
    } else {
      log(response);
      update();
      return false;
    }
  }

  Future<bool> getNewProducts() async {
    newInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.productByRemarksUrl('new'));
    newInProgress = false;
    if (response != null && response['msg'] == 'success') {
      newProductModel = ProductModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getSpecialProducts() async {
    specialInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.productByRemarksUrl('special'));
    specialInProgress = false;
    if (response != null && response['msg'] == 'success') {
      specialProductModel = ProductModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getProductsByCategory(String categoryId) async {
    productByCategoryInProgress = true;
    update();
    final response =
        await NetworkUtils().getMethod(Urls.productByCategoryUrl(categoryId));
    productByCategoryInProgress = false;
    if (response != null && response['msg'] == 'success') {
      productByCategoryModel = ProductModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

}

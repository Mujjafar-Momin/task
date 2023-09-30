// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:demo/data/network/api_client.dart';
import 'package:demo/model/product_model.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets.dart';
import '../view/product/product_details_page.dart';

class ProductDetailViewModel with ChangeNotifier {
  ProductElement? productElement;
  bool isLoading = true;
  Future getProductDetailsData(BuildContext context, int id) async {
   final responseData = await ApiClient.client
        .getRequest("products/$id")
        .onError((error, stackTrace) => debugPrint(error.toString()));
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      productElement = ProductElement.fromJson(jsonResponse);
      debugPrint(productElement.toString());
      isLoading = false;
      notifyListeners();
    } else {
      Utils.CustomAlertBar(
          context: context,
          description: "",
          title: responseData.error,
          color: Colors.red);
    }
    notifyListeners();
  }

  void isSelected(product) {
      product!.isFavorite = !product!.isFavorite ;
      debugPrint("make");
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}

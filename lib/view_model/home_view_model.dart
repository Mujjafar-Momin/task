// ignore_for_file: use_build_context_synchronously


import 'package:demo/data/network/api_client.dart';
import 'package:demo/model/product_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  Product? product;
  List<ProductElement> productElementList = [];
  bool isLoading = true;
  ProductElement? selectedProduct;

  Future getProductData() async {
    final responseData = await ApiClient.client
        .getRequest("products")
        .onError((error, stackTrace) => debugPrint(error.toString()));
    if (responseData != null) {
      final jsonData = (responseData.body.toString());
      debugPrint(jsonData);
      product = productFromJson(jsonData);
      productElementList = product!.products;
    }
    isLoading = false;
    notifyListeners();
  }

  selecteFavorite(ProductElement productElement) {
    productElementList.forEach((element) {
      if (element.id == productElement.id) {
        productElement.isFavorite = !productElement.isFavorite;
      }
    });
    notifyListeners();
  }

  updateFavorite(product) {
    productElementList.forEach((element) {
      if (element.id == product.id) {
        element.isFavorite = product.isFavorite;
      }
    });

    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}

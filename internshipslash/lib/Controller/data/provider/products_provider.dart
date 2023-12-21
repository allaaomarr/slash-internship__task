import 'package:flutter/cupertino.dart';
import 'package:internshipslash/Model/products_model.dart';

import '../Network/Dio.dart';

class ProductsProvider extends ChangeNotifier {
  bool isLoading = false;
  late List<ProductsModel> products = [];
  void getProducts() {
    isLoading =true;
    notifyListeners();
    GetAllProducts("https://slash-backend.onrender.com/product").then((value) {
      products = value;
      print(products);
      notifyListeners();


    });
    isLoading = false;
    notifyListeners();
  }
}
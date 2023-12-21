import 'package:flutter/cupertino.dart';
import 'package:internshipslash/Model/product_details_model.dart';


import '../Network/Dio.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  late ProductDetails productdetails ;
  void getProductDetails(int? id) {
    isLoading =true;
    notifyListeners();
    GetProductDetails("https://slash-backend.onrender.com/product/$id").then((value) {
      productdetails = value;
      print(productdetails);
      notifyListeners();


    });
    isLoading = false;
    notifyListeners();
  }
}
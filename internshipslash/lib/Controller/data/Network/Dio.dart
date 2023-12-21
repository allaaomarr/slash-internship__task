import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:internshipslash/Model/product_details_model.dart';
import 'package:internshipslash/Model/products_model.dart';

GetAllProducts(String url) async {
  final dio = Dio();
  Response response;


  try {
    response = await dio.get(
      '$url', options: Options(
        receiveDataWhenStatusError: true,

        receiveTimeout: Duration(seconds: 60),
        followRedirects: false,

        validateStatus: (status) => true,
        headers: {
          // "Accept": "application/json",
          //'Authorization': 'Bearer ${token}',
        }
    ),
    );

    var data = List<ProductsModel>.from(
        response.data['data'].map((element) =>
            ProductsModel.fromJson(element)));

   //  print(data.length);
//print(data[1].variations[0].price);
    return data;
    // The below request is the same as above.
  }
  on DioError catch (ex) {
    if (ex.type == DioErrorType.connectionTimeout) {
      throw Exception("Connection  Timeout Exception");
    }
    throw Exception(ex.message);
  }
}
GetProductDetails(String url) async {
  final dio = Dio();
  Response response;


  try {
    response = await dio.get(
      '$url', options: Options(
        receiveDataWhenStatusError: true,

        receiveTimeout: Duration(seconds: 60),
        followRedirects: false,

        validateStatus: (status) => true,
        headers: {
          // "Accept": "application/json",
          //'Authorization': 'Bearer ${token}',
        }
    ),
    );
   /* var data = List<ProductDetails>.from(
        response.data.map((element) =>
            ProductDetails.fromJson(element)));*/
    ProductDetails data = ProductDetails.fromJson(response.data);
    print(data.variations[0].productPropertiesValues[0].value);
    print(data.variations[0].price);
   print(data.availableProperties[0].property);
    print(data.variations[0].productVarientImages[0]);
    return data;
    // The below request is the same as above.
  }
  on DioError catch (ex) {
    if (ex.type == DioErrorType.connectionTimeout) {
      throw Exception("Connection  Timeout Exception");
    }
    throw Exception(ex.message);
  }
}
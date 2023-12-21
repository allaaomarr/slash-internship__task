import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Controller/data/provider/product_details_provider.dart';
import 'Controller/data/provider/products_provider.dart';
import 'View/home.dart';

void main() {
  runApp(  Sizer(
      builder:
      (BuildContext context, Orientation orientation, DeviceType deviceType) {

    return  MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider(),

          ),
          ChangeNotifierProvider<ProductDetailsProvider>(
            create: (_) => ProductDetailsProvider(),

          ),



 ],



  builder: (context, child) {
          return MaterialApp(
home: Home(),debugShowCheckedModeBanner: false,
          );
  }
    );
     },

  ));

}



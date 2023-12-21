 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshipslash/View/product_page.dart';
import 'package:provider/provider.dart';

import '../Controller/data/Network/Dio.dart';
import '../Controller/data/provider/product_details_provider.dart';
import '../Controller/data/provider/products_provider.dart';

class Home extends StatefulWidget {
   const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   @override
   void initState() {
     super.initState();

     //  GetdataFunction("https://slash-backend.onrender.com/product");
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<ProductsProvider>(context, listen: false).getProducts();
       Provider.of<ProductDetailsProvider>(context, listen: false).getProductDetails(21);
     });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(backgroundColor:Colors.black,centerTitle:true, title:  Text("Slash.",style: (TextStyle(color: Colors.white,fontSize:35)),),),
       backgroundColor: Colors.black,
         body: Consumer<ProductsProvider>(builder: (context, value, child) {
            if (value.isLoading) {
           return const Center(
              child: CircularProgressIndicator(color: Colors.white,),
              );
            }
           return SafeArea(child: Padding(
             padding: const EdgeInsets.all(20),
             child: Column(
children: [
  Expanded(child: GridView.builder(
             //shrinkWrap: true,
                 itemCount: value.products.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                 crossAxisSpacing: 4.0,
                   mainAxisSpacing: 8.0,

                   childAspectRatio: 0.7,
                 ),
                 itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.fromLTRB(5, 0,5, 0),
                     child: InkWell(

                       onTap: () {
                   print("Navigating to product page with ID: ${value.products[index].id}, Argument: 0");
                   Navigator.push(
                   context,
                   MaterialPageRoute(
                   builder: (context) => product_page(value.products[index].id, 0),
                   ),
                   );

                   },


                       child:



                             Container(
                               height: 180,
                               width: 140,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: [

                                 Container(
                                   height: 150,
                                   //width: 150,

                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadiusDirectional.circular(19),
                                   ),
                                   child:  CachedNetworkImage(
                                     imageUrl: value.products[index].variations[0].productVarientImages[0],
                                     placeholder: (context, url) => CircularProgressIndicator(),
                                     errorWidget: (context, url, error) => Icon(Icons.error),
                                     fit: BoxFit.contain
                                   ),


                                 ),
SizedBox(height: 10,),
                               Wrap(
                                   children:[
                                     Text(value.products[index].brandName.toString() +"- " +value.products[index].name,softWrap: true,style: (TextStyle(color: Colors.white,fontSize: 14.0,)),),]),
                               Container(
                                // width :20,
                                 child: Row(
                                   children: [

                     //  Spacer(),
                     /*  CircleAvatar(
                        // radius: 10,
                      child: CachedNetworkImage(
                         imageUrl: value.products[index].brandLogoUrl,
                         placeholder: (context, url) => CircularProgressIndicator(),
                         errorWidget: (context, url, error) => Icon(Icons.error),),),
*/
                                   ],
                                 ),
                               ),


                               Row(
                                 children: [
                                   Text("EGP "+value.products[index].variations[0].price.toString() ,style: (TextStyle(color: Colors.white)),),
                                 Spacer(),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: InkWell(child: Icon(Icons.favorite_border,color: Colors.white,)),
                                   ),

                                  InkWell(child: Icon(Icons.shopping_cart,color: Colors.white,)),
                                 ],
                               ),
                           //  Text(value.products[index].description.toString())
                          //   Text(value.products[index].variations[index].productVarientImages[index]),
                           ],
                         ),
                             ),

                     ),
                   );
                 }),
  )
],
             ),
           ),
           );
         } ),
     );
   }
}

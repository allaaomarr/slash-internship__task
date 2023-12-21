import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Controller/data/provider/product_details_provider.dart';

class product_page extends StatefulWidget {
  int? id;
  int index;
  product_page(this.id, this.index) : super();

  @override
  State<product_page> createState() => _product_pageState();
}

class _product_pageState extends State<product_page> {
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .getProductDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(
          "Product Details",
          style: (TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer<ProductDetailsProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(children: [
                Expanded(
                  child: Card(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 300,
                              child: Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value
                                        .productdetails
                                        .variations[widget.index]
                                        .productVarientImages
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          height: 270,
                                          width: 260,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(20),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: value
                                                .productdetails
                                                .variations[widget.index]
                                                .productVarientImages[index]
                                                .imagePath,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          // price brand name
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        value.productdetails.name,
                                        style: (TextStyle(color: Colors.white)),
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                          radius: 25,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                value.productdetails.brandImage,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "EGP " +
                                            value.productdetails
                                                .variations[widget.index].price
                                                .toString(),
                                        style: (TextStyle(color: Colors.white)),
                                      ),
                                      Spacer(),
                                      Text(
                                        value.productdetails.brandName,
                                        style: (TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Color list if available

                          Container(
                            child: Visibility(
                              visible:
                                  value.productdetails.availableProperties.any(
                                (property) => property.property == "Color",
                              ),
                              replacement: Text('',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 0)),
                              child: Expanded(

                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: value.productdetails
                                      .availableProperties.length,
                                  itemBuilder: (context, index1) {
                                    if (value
                                            .productdetails
                                            .availableProperties[index1]
                                            .property ==
                                        "Color" && value.productdetails
                                        .availableProperties.length != null ) {
                                      return Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: value
                                                        .productdetails
                                                        .availableProperties[
                                                            index1]
                                                        .values
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: _hexToColor(value
                                                                .productdetails
                                                                .availableProperties[
                                                                    index1]
                                                                .values[index]
                                                                .value),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(50),
                                                                border: Border.all(
                                                                  color: Colors.white, // Set your desired border color here
                                                                  width: 2.0, // Set the width of the border
                                                                ),
                                                              ),

                                                          child: InkWell(
                                                            onTap: () => Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    product_page(
                                                                        widget.id,
                                                                        index),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
// Size if available
                          Container(
                            child: Visibility(
                              visible:
                                  value.productdetails.availableProperties.any(
                                (property) => property.property == "Size",
                              ),
                              replacement: Container(),
                              child: Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Select " + "Size",
                                            style: (TextStyle(
                                              color: Colors.white,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: value.productdetails
                                            .availableProperties.length,
                                        itemBuilder: (context, index1) {
                                          if (value
                                                  .productdetails
                                                  .availableProperties[index1]
                                                  .property ==
                                              "Size" && value.productdetails
                                              .availableProperties.length != null ) {
                                            return Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                height: 600,
                                                width: 500,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: Expanded(
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount: value
                                                                      .productdetails
                                                                      .availableProperties[
                                                                          index1]
                                                                      .values
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
    if (value
        .productdetails
        .variations[widget
        .index].id ==
    value
        .productdetails
        .availableProperties[index1]
        .values[index]
        .id) {
      return Container(
        height:
        50,
        child:
        ElevatedButton(
          onPressed:
              () {},
          child:
          Text(
            value
                .productdetails
                .availableProperties[index1]
                .values[index]
                .value
                .toString(),
            style: (TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold)),
          ),
          onHover:
              (value) {},
          style:
          ButtonStyle(
            backgroundColor:
            MaterialStateProperty.resolveWith<Color>((
                Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Color(0xffB8EE2E);
                // Color to change to when hovered
              }
              return Color(0xffB8EE2E); // Default color
            }),
            // Background color
            foregroundColor:
            MaterialStateProperty.resolveWith<Color>((
                Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.black;
                // Color to change to when hovered
              }
              return Colors.black; // Default color
            }),
            shadowColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
            // Text color
            padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(10.0), // Padding
            ),
            minimumSize: MaterialStateProperty.all<Size>(Size(
                10,
                0)), // Set the minimum size
          ),
        ),
      );
    }else{
      return Container();
    }
    })),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
// material if available
                          Container(
                            child: Visibility(
                              visible:
                                  value.productdetails.availableProperties.any(
                                (property) => property.property == "Materials",
                              ),
                              replacement: Text('',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 0)),
                              child: Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Select " + "Material",
                                            style: (TextStyle(
                                              color: Colors.white,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: value.productdetails
                                            .availableProperties.length,
                                        itemBuilder: (context, index1) {
                                          if (value
                                                  .productdetails
                                                  .availableProperties[index1]
                                                  .property ==
                                              "Materials" && value.productdetails
                                              .availableProperties.length != null ) {
                                            return Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                height: 600,
                                                width: 500,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: Expanded(
                                                          child:
                                                              ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: value
                                                            .productdetails
                                                            .availableProperties[
                                                                index1]
                                                            .values
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (value
                                                                  .productdetails
                                                                  .variations[
                                                                      widget
                                                                          .index]
                                                                  .id ==
                                                              value
                                                                  .productdetails
                                                                  .availableProperties[
                                                                      index1]
                                                                  .values[index]
                                                                  .id) {
                                                            return Container(
                                                              height: 50,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  value
                                                                      .productdetails
                                                                      .availableProperties[
                                                                          index1]
                                                                      .values[widget
                                                                          .index]
                                                                      .value
                                                                      .toString(),
                                                                  style: (TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                ),
                                                                onHover:
                                                                    (value) {},
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.resolveWith<
                                                                      Color>((Set<
                                                                          MaterialState>
                                                                      states) {
                                                                    if (states.contains(
                                                                        MaterialState
                                                                            .hovered)) {
                                                                      return Color(
                                                                          0xffB8EE2E);
                                                                      // Color to change to when hovered
                                                                    }
                                                                    return Color(
                                                                        0xffB8EE2E); // Default color
                                                                  }),
                                                                  // Background color
                                                                  foregroundColor: MaterialStateProperty.resolveWith<
                                                                      Color>((Set<
                                                                          MaterialState>
                                                                      states) {
                                                                    if (states.contains(
                                                                        MaterialState
                                                                            .hovered)) {
                                                                      return Colors
                                                                          .black;
                                                                      // Color to change to when hovered
                                                                    }
                                                                    return Colors
                                                                        .black; // Default color
                                                                  }),
                                                                  shadowColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .transparent),
                                                                  // Text color
                                                                  padding:
                                                                      MaterialStateProperty
                                                                          .all<
                                                                              EdgeInsetsGeometry>(
                                                                    EdgeInsets.all(
                                                                        10.0), // Padding
                                                                  ),
                                                                  minimumSize: MaterialStateProperty.all<
                                                                          Size>(
                                                                      Size(10,
                                                                          0)), // Set the minimum size
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return Container(
                                                              color: Colors.red,
                                                            );
                                                          }
                                                        },
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Text('',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 0));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
// materials ,size expanded3
                          /*   Expanded(
flex :1,
                          child: Visibility(
                            visible: value.productdetails.availableProperties.any(
                                  (property) => property.property != "Color",
                            ),
                          child:
                          ListView.builder(

                              shrinkWrap: true,
                             // physics: NeverScrollableScrollPhysics(),
scrollDirection: Axis.vertical,
                              itemCount:value.productdetails.availableProperties.length,
                              itemBuilder: (context, index1) {
                                if (value.productdetails
                                    .availableProperties[index1].property !=
                                    "Color") {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 250,
                                      width: 250,

                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text("Select " +
                                                    value.productdetails
                                                        .availableProperties[index1]
                                                        .property,
                                                  style: (TextStyle(
                                                    color: Colors.white,)),),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            child:

                                            Expanded(

                                                child:
                                                ListView.builder(

                                                    shrinkWrap: true,
                                                    scrollDirection: Axis
                                                        .horizontal,

                                                    itemCount: value
                                                        .productdetails
                                                        .availableProperties[index1]
                                                        .values.length,
                                                    itemBuilder: (context,
                                                        index) {
                                                      if (value.productdetails
                                                          .variations[widget.index].id
                                                          .toString() == value
                                                          .productdetails
                                                          .availableProperties[index1]
                                                          .values[index].id
                                                          .toString()) {
                                                        return
                                                          Container(
                                                            height: 50,
                                                            child: ElevatedButton(

                                                              onPressed: () {},
                                                              child:

                                                              Text(value
                                                                  .productdetails
                                                                  .availableProperties[index1]
                                                                  .values[index]
                                                                  .value
                                                                  .toString(),
                                                                style: (TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight: FontWeight
                                                                        .bold)),),

                                                              onHover: (value) {


                                                              },
                                                              style: ButtonStyle(

                                                                backgroundColor: MaterialStateProperty
                                                                    .resolveWith<
                                                                    Color>((Set<
                                                                    MaterialState> states) {
                                                                  if (states
                                                                      .contains(
                                                                      MaterialState
                                                                          .hovered)) {
                                                                    return Color(
                                                                        0xffB8EE2E);
                                                                    // Color to change to when hovered
                                                                  }
                                                                  return Color(
                                                                      0xffB8EE2E); // Default color
                                                                }),
                                                                // Background color
                                                                foregroundColor: MaterialStateProperty
                                                                    .resolveWith<
                                                                    Color>((Set<
                                                                    MaterialState> states) {
                                                                  if (states
                                                                      .contains(
                                                                      MaterialState
                                                                          .hovered)) {
                                                                    return Colors
                                                                        .black;
                                                                    // Color to change to when hovered
                                                                  }
                                                                  return Colors
                                                                      .black; // Default color
                                                                }),
                                                                shadowColor: MaterialStateProperty
                                                                    .all<Color>(
                                                                    Colors
                                                                        .transparent),
                                                                // Text color
                                                                padding: MaterialStateProperty
                                                                    .all<
                                                                    EdgeInsetsGeometry>(
                                                                  EdgeInsets
                                                                      .all(
                                                                      10.0), // Padding
                                                                ),
                                                                minimumSize: MaterialStateProperty
                                                                    .all<Size>(
                                                                    Size(10,
                                                                        0)), // Set the minimum size

                                                              ),
                                                            ),
                                                          );
                                                      }
                                                      else {
                                                        return Container();
                                                      }
                                                    }

                                                )),
                                          ),


                                        ],
                                      ),


                                    ),
                                  );
                                }else{
                                  return Container();
                                }
                              }

                          ),
                        ),
                        ),
*/
                          SingleChildScrollView(
                            child: Expanded(
                              flex: 1,
                              child: ExpandablePanel(
                                header: Text("Description",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                collapsed: Text("",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white)),
                                expanded: Text(
                                    value.productdetails.description.toString(),
                                    softWrap: true,
                                    style: TextStyle(color: Colors.white)),
                                theme: ExpandableThemeData(
                                  iconColor: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          //  Text(value.products[index].description.toString())
                        ],
                      )),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

Color _hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  int value = int.parse(hexColor, radix: 16);
  print(Color(value));
  return Color(0xFF000000 + value);
}

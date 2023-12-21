class ProductsModel{
  final int? id;
  final String name;
  final String description;
  final int? brandId;
  final String? brandName;
  final String brandLogoUrl;
  final double rating;
  final List<ProductVariation> variations;
  //final List<ProductProperty> availableProperties;
  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.brandId,
    required this.brandName,
    required this.brandLogoUrl,
    required this.rating,
    required this.variations,
//    required this.availableProperties,
  });
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brandId: json['brandId'],
      brandName: json['Brands']['brand_name'],
      brandLogoUrl: json['Brands']['brand_logo_image_path'],
      rating: json['Brands']['brand_rating'].toDouble(),
      variations: (json['ProductVariations'] as List)
          .map((v) => ProductVariation.fromJson(v))
          .toList(),
    //  availableProperties: (json['AvailableProperties'] as List)
       //  .map((p) => ProductProperty.fromJson(p))
         // .toList(),
    );
  }

}

class ProductVariation {
  final int? id;
  final int? productId;
  final num price;
  final int? quantity;
  final bool? inStock;  //to enable/disable addToCart button
  final List<String> productVarientImages;
 // final List<ProductPropertyAndValue> productPropertiesValues;
  ProductVariation({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.inStock,
    required this.productVarientImages,
   // required this.productPropertiesValues,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      id: json['id'],
      productId: json['product_id'],
      price: json['price'],
      quantity: json['quantity'],
      inStock: json['inStock'],
      productVarientImages: List<String>.from(json['ProductVarientImages']
          .map((image) => image['image_path'] as String)),
    /*  productPropertiesValues: (json['ProductPropertiesValues'] as List)
          .map((prop) => ProductPropertyAndValue.fromJson(prop))
          .toList(),*/
    );
  }
}



class ProductPropertyAndValue {
  final String property;
  final String value;

  ProductPropertyAndValue({
    required this.property,
    required this.value,
  });

  factory ProductPropertyAndValue.fromJson(Map<String, dynamic> json) {
    return ProductPropertyAndValue(
      property: json['property'],
      value: json['value'],
    );
  }
}

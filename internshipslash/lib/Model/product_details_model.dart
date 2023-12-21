
class ProductDetails {
  final int id;
  final String name;
  final String description;
  final int brandId;
  final int bostaSizeId;
  final double productRating;
  final int estimatedDaysPreparing;

  // final SizeChart? sizeChart;
  final SubCategory subCategory;
  final List<Variation> variations;
 final List<AvailableProperty> availableProperties;
  final String brandName;
  final String brandImage;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.brandId,
    required this.bostaSizeId,
    required this.productRating,
    required this.estimatedDaysPreparing,
    // required this.sizeChart,
    required this.subCategory,
    required this.variations,
 required this.availableProperties,
    required this.brandName,
    required this.brandImage,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['data']['id'],
      name: json['data']['name'],
      description: json['data']['description'],
      brandId: json['data']['brand_id'],
      bostaSizeId: json['data']['bosta_size_id'],
      productRating: json['data']['product_rating'].toDouble(),
      estimatedDaysPreparing: json['data']['estimated_days_preparing'],
      subCategory: SubCategory.fromJson(json['data']['subCategory']),
      variations: List<Variation>.from(
        json['data']['variations'].map((v) => Variation.fromJson(v)),
      ),


    availableProperties: (json['data']["avaiableProperties"] as List<dynamic>?)
        ?.map((v) => AvailableProperty.fromJson(v))
        ?.toList() ?? [],


      brandName: json['data']['brandName'],
      brandImage: json['data']['brandImage'],
    );
  }
}

class SizeChart {
  // Add SizeChart properties if applicable
}

class SubCategory {
  final int id;
  final String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}


  class Variation {
    final int id;
    final double price;
    final int quantity;
    final bool inStock;
    final List<ProductVarientImage> productVarientImages;
    final List<ProductPropertiesValue> productPropertiesValues;
    final dynamic productStatus; // Assuming productStatus can be of any type
    final bool isDefault;
    final int productVariationStatusId;

    Variation({
      required this.id,
      required this.price,
      required this.quantity,
      required this.inStock,
      required this.productVarientImages,
      required this.productPropertiesValues,
      required this.productStatus,
      required this.isDefault,
      required this.productVariationStatusId,
    });


    factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
    id: json['id'],
    price: (json['price'] as num?)?.toDouble() ?? 0.0, // Provide a default value for null
    quantity: json['quantity'] ?? 0, // Provide a default value for null
    inStock: json['inStock'] ?? false, // Provide a default value for null
    productVarientImages: List<ProductVarientImage>.from(
    json['ProductVarientImages']
        .map((v) => ProductVarientImage.fromJson(v)),
    ),
    productPropertiesValues: List<ProductPropertiesValue>.from(
    json['productPropertiesValues']
        .map((v) => ProductPropertiesValue.fromJson(v)),
    ),
    productStatus: json['productStatus'],
    isDefault: json['isDefault'] ?? false, // Provide a default value for null
    productVariationStatusId: json['product_variation_status_id'] as int? ?? 0, // Provide a default value for null
    );
    }

  }

class ProductVarientImage {
  final int id;
  final String imagePath;
  //final int productVarientId;
  final String createdAt;
  final String updatedAt;

  ProductVarientImage({
    required this.id,
    required this.imagePath,
   // required this.productVarientId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductVarientImage.fromJson(Map<String, dynamic> json) {
    return ProductVarientImage(
      id: json['id'],
      imagePath: json['image_path'],
    //  productVarientId: json['product_varient_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ProductPropertiesValue {
  final String value;
  final String property;

  ProductPropertiesValue({required this.value, required this.property});

  factory ProductPropertiesValue.fromJson(Map<String, dynamic> json) {
    return ProductPropertiesValue(
      value: json['value'],
      property: json['property'],
    );
  }
}

class AvailableProperty {
  final String property;
  final List<Value> values;

  AvailableProperty({required this.property, required this.values});

 factory AvailableProperty.fromJson(Map<String, dynamic> json) {
      return AvailableProperty(
        property: json['property'],
        values: List<Value>.from(json['values'].map((v) => Value.fromJson(v))),
      );
    }
}

class Value {
  final String value;
  final int id;

  Value({required this.value, required this.id});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      value: json['value'],
      id: json['id'],
    );
  }
}
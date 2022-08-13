import 'dart:convert';

ProductsModel convertProducts(String str) =>
    ProductsModel.fromJson(json.decode(str));

AllProductsModel convertAllProducts(String str) =>
    AllProductsModel.fromJson(json.decode(str));

class AllProductsModel {
  AllProductsModel({
    required this.products,
    required this.totalProducts,
  });
  late final List<Products> products;
  late final int totalProducts;

  AllProductsModel.fromJson(Map<String, dynamic> json) {
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    totalProducts = json['totalProducts'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['totalProducts'] = totalProducts;
    return _data;
  }
}

class ProductsModel {
  ProductsModel({
    required this.keyword,
    required this.products,
    required this.totalProducts,
  });
  late final String keyword;
  late final List<Products> products;
  late final int totalProducts;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword']!;
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    totalProducts = json['totalProducts'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['keyword'] = keyword;
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['totalProducts'] = totalProducts;
    return _data;
  }
}

class Products {
  Products({
    required this.brandName,
    required this.heroImage,
    required this.image135,
    required this.image250,
    required this.image450,
    required this.displayName,
    required this.rating,
    required this.reviews,
  });
  late final String brandName;
  late final String heroImage;
  late final String image135;
  late final String image250;
  late final String image450;
  late final String displayName;
  late final String rating;
  late final String reviews;

  Products.fromJson(Map<String, dynamic> json) {
    brandName = json['brandName'];
    heroImage = json['heroImage'];
    image135 = json['image135'];
    image250 = json['image250'];
    image450 = json['image450'];
    displayName = json['displayName'];
    rating = json['rating'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brandName'] = brandName;
    _data['heroImage'] = heroImage;
    _data['image135'] = image135;
    _data['image250'] = image250;
    _data['image450'] = image450;
    _data['displayName'] = displayName;
    _data['rating'] = rating;
    _data['reviews'] = reviews;
    return _data;
  }
}

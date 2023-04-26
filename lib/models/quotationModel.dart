import 'dart:convert';

class QuotationModel {
  final String name;
  final String imgUrl;
  final String category;
  final int quantity;
  final String price;
  QuotationModel({
    required this.name,
    required this.imgUrl,
    required this.category,
    required this.quantity,
    required this.price
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'category': category,
      'quantity': quantity,
      'price':price
    };
  }

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      category: map['category'] ?? '',
      quantity: map['quantity'] ?? '',

      price: map['price']??''
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotationModel.fromJson(String source) =>
      QuotationModel.fromMap(json.decode(source));
}

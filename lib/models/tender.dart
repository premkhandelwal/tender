import 'dart:convert';

class Tender {
  final String name;
  final String imgUrl;
  final String category;
  final int quantity;
  Tender({
    required this.name,
    required this.imgUrl,
    required this.category,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'category': category,
      'quantity': quantity,
    };
  }

  factory Tender.fromMap(Map<String, dynamic> map) {
    return Tender(
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      category: map['category'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tender.fromJson(String source) => Tender.fromMap(json.decode(source));
}

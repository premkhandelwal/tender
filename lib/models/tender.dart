import 'dart:convert';

class Tender {
  final String name;
  final String imgUrl;
  final String category;
  final int quantity;
  final List<Map<String, dynamic>> quotes;
  Tender({
    required this.name,
    required this.imgUrl,
    required this.category,
    required this.quantity,
    required this.quotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'category': category,
      'quantity': quantity,
      'quotes': quotes
    };
  }

  factory Tender.fromMap(Map<String, dynamic> map) {
    return Tender(
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      category: map['category'] ?? '',
      
      quantity: map['quantity'] ?? '',
      quotes: map?['notes'] is Iterable ? List.from(map['notes']) : [],
      // quotes: List<Map<String, dynamic>>.from(map['quotes'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tender.fromJson(String source) => Tender.fromMap(json.decode(source));
}

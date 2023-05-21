import 'dart:convert';

class Tender {
  final String tenderQuotId;
  final String name;
  final String imgUrl;
  final String category;
  final int quantity;
  final double? price;
  final String? awardedId;
  final String? tenderId;
  final bool? accepted;
  Tender({
    required this.tenderQuotId,
    required this.name,
    required this.imgUrl,
    required this.category,
    required this.quantity,
    this.price,
    this.awardedId,
    this.tenderId,
    this.accepted
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
        tenderQuotId: map["tenderQuotId"] ?? '',
        name: map['name'] ?? '',
        imgUrl: map['imgUrl'] ?? '',
        category: map['category'] ?? '',
        quantity: map['quantity'] ?? '',
        price: map["quotationPrice"],
        tenderId: map["tenderId"],
        accepted: map["accepted"],
        // quotes: List<Map<String, dynamic>>.from(map['quotes'] as List),
        );
  }

  String toJson() => json.encode(toMap());

  factory Tender.fromJson(String source) => Tender.fromMap(json.decode(source));
}

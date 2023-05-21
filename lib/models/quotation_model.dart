import 'dart:convert';

class QuotationModel {
  final String tenderId;
  final String userId;
  
  QuotationModel({
    required this.tenderId,
    required this.userId,

  });

  Map<String, dynamic> toMap() {
    return {
      'name': tenderId,
      'imgUrl': userId,
   
    };
  }

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      tenderId: map['name'] ?? '',
      userId: map['imgUrl'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotationModel.fromJson(String source) =>
      QuotationModel.fromMap(json.decode(source));
}

import 'dart:convert';

import 'package:vender/models/user.dart';

class Quotes {
  final String tenderQuotId;
  final String tenderId;
  final Users userInfo;
  final double quotationPrice;
  Quotes({
    required this.tenderQuotId,
    required this.tenderId,
    required this.userInfo,
    required this.quotationPrice,
  });

 

  Map<String, dynamic> toMap() {
    return {
      'tenderId': tenderId,
      'userInfo': userInfo.toMap(),
      'quotationPrice': quotationPrice,
    };
  }

  factory Quotes.fromMap(Map<String, dynamic> map) {
    return Quotes(
      tenderQuotId: map["tenderQuotId"] ?? '',
      tenderId: map['tenderId'] ?? '',
      userInfo: Users.fromMap(map['userInfo'].toMap()),
      quotationPrice: map['quotationPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quotes.fromJson(String source) => Quotes.fromMap(json.decode(source));

  @override
  String toString() =>
      'Quotes(tenderId: $tenderId, userInfo: $userInfo, quotationPrice: $quotationPrice)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quotes &&
        other.tenderId == tenderId &&
        other.userInfo == userInfo &&
        other.quotationPrice == quotationPrice;
  }

  @override
  int get hashCode =>
      tenderId.hashCode ^ userInfo.hashCode ^ quotationPrice.hashCode;
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

class Users {
  final String docId;
  final String name;
  final String emailId;
  final String googleId;
  final String type;
  final List coordinates;
  Users({
    required this.docId,
    required this.name,
    required this.emailId,
    required this.googleId,
    required this.type,
    required this.coordinates,
  });

  Users copyWith({
    String? name,
    String? emailId,
    String? googleId,
    String? type,
    List? coordinates,
  }) {
    return Users(
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      googleId: googleId ?? this.googleId,
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates, 
      docId: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emailId': emailId,
      'google_id': googleId,
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'] ?? '',
      emailId: map['email'] ?? '',
      googleId: map['google_id'] ?? '',
      type: map['type'] ?? '',
      coordinates: List.from(map['coordinates']), 
      docId: map['docId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, emailId: $emailId, googleId: $googleId, type: $type, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.name == name &&
        other.emailId == emailId &&
        other.googleId == googleId &&
        other.type == type &&
        listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        emailId.hashCode ^
        googleId.hashCode ^
        type.hashCode ^
        coordinates.hashCode;
  }
}

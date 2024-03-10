import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CatFactModel {
  final String fact;
  final String length;
  CatFactModel({
    required this.fact,
    required this.length,
  });

  CatFactModel copyWith({
    String? fact,
    String? length,
  }) {
    return CatFactModel(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fact': fact,
      'length': length,
    };
  }

  factory CatFactModel.fromMap(Map<String, dynamic> map) {
    return CatFactModel(
      fact: map['fact'] as String,
      length: map['length'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatFactModel.fromJson(String source) => CatFactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatFactModel(fact: $fact, length: $length)';

  @override
  bool operator ==(covariant CatFactModel other) {
    if (identical(this, other)) return true;

    return other.fact == fact && other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;
}

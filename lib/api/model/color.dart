import 'package:json_annotation/json_annotation.dart';

part 'color.g.dart';

@JsonSerializable()
class Color {
  const Color(this.r, this.g, this.b);

  final int r;
  final int g;
  final int b;

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
}
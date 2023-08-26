import 'package:cookie/api/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable()
class Comments {
  const Comments(this.comments, this.next);

  final List<Comment> comments;
  final String? next;

  factory Comments.fromJson(Map<String, dynamic> json) => _$CommentsFromJson(json);
}
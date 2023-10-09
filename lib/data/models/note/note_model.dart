import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  final String? key;
  final String? title;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  const NoteModel({
    this.title,
    this.content,
    this.key,
    this.createdAt,
    this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

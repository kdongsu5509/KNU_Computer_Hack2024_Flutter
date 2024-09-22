import 'package:json_annotation/json_annotation.dart';

part 'my_item.g.dart';

@JsonSerializable()
class MyItem {
  final int id;
  final String createdAt;
  final String title;
  final String name;
  final String content;
  final String thumbnail;
  final String moveInDate; // 필요에 따라 DateTime으로 변경 가능
  final bool isSold;

  MyItem({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.name,
    required this.content,
    required this.thumbnail,
    required this.moveInDate,
    required this.isSold,
  });

  factory MyItem.fromJson(Map<String, dynamic> json) => _$MyItemFromJson(json);

  Map<String, dynamic> toJson() => _$MyItemToJson(this); // 수정된 부분
}

import 'package:json_annotation/json_annotation.dart';

part 'ItemDetailResponse.g.dart';

@JsonSerializable()
class ItemDetailResponse {
  final int id;
  final String title;
  final String content;
  final String address;
  final int deposit;
  final int rent;
  final bool maintenanceFeeIncluded;
  final String moveInDate;
  final String expirationDate;
  final String door;
  final int floor;
  final int roomCount;
  final String windowDirection;
  final List<String> images;
  final String createdAt;

  ItemDetailResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.address,
    required this.deposit,
    required this.rent,
    required this.maintenanceFeeIncluded,
    required this.moveInDate,
    required this.expirationDate,
    required this.door,
    required this.floor,
    required this.roomCount,
    required this.windowDirection,
    required this.images,
    required this.createdAt,
  });

  factory ItemDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailResponseToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailResponse _$ItemDetailResponseFromJson(Map<String, dynamic> json) =>
    ItemDetailResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      address: json['address'] as String,
      deposit: (json['deposit'] as num).toInt(),
      rent: (json['rent'] as num).toInt(),
      maintenanceFeeIncluded: json['maintenanceFeeIncluded'] as bool,
      moveInDate: json['moveInDate'] as String,
      expirationDate: json['expirationDate'] as String,
      door: json['door'] as String,
      floor: (json['floor'] as num).toInt(),
      roomCount: (json['roomCount'] as num).toInt(),
      windowDirection: json['windowDirection'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ItemDetailResponseToJson(ItemDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'address': instance.address,
      'deposit': instance.deposit,
      'rent': instance.rent,
      'maintenanceFeeIncluded': instance.maintenanceFeeIncluded,
      'moveInDate': instance.moveInDate,
      'expirationDate': instance.expirationDate,
      'door': instance.door,
      'floor': instance.floor,
      'roomCount': instance.roomCount,
      'windowDirection': instance.windowDirection,
      'images': instance.images,
      'createdAt': instance.createdAt,
    };

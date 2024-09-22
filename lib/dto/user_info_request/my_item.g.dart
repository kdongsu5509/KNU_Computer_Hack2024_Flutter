// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyItem _$MyItemFromJson(Map<String, dynamic> json) => MyItem(
      id: (json['id'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      title: json['title'] as String,
      name: json['name'] as String,
      content: json['content'] as String,
      thumbnail: json['thumbnail'] as String,
      moveInDate: json['moveInDate'] as String,
      isSold: json['isSold'] as bool,
    );

Map<String, dynamic> _$MyItemToJson(MyItem instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'name': instance.name,
      'content': instance.content,
      'thumbnail': instance.thumbnail,
      'moveInDate': instance.moveInDate,
      'isSold': instance.isSold,
    };

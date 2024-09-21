import 'package:dio/dio.dart';

final dio = Dio();

final baseUrl = 'http://kkym.duckdns.org:8080';


Future<List<Map<String, dynamic>>> HouseListRequest() async {
  try{
    final resp = await dio.get(
      baseUrl+'/api/items',
    );
    print("resp.data: ${resp.data}");

    // print("runtimeType :  ${houseList.runtimeType}");
    final data = resp.data.map((data) => {
      'id': data['id'],
      'createdAt': data['createdAt'],
      'title': data['title'],
      'content': data['content'],
      'thumbnail': data['thumbnail'],
      'moveInDate': data['moveInDate'],
      'isSold': data['isSold'],
    }).map((data) => Map<String, dynamic>.from(data)).cast<Map<String, dynamic>>().toList();

    print(data);
    return data;

  }on DioException catch(e){
    print(e.message);
    return [];
  }

}

Future<List<Map<String, dynamic>>> HouseDetailRequest({
  required int id,
}) async {
  try{
    final resp = await dio.get(
      baseUrl+'/api/items/${id}',
    );
    print("resp.data: ${resp.data}");

    // print("runtimeType :  ${houseList.runtimeType}");
    final data = resp.data.map((data) => {
      'id': data['id'],
      'createdAt': data['createdAt'],
      'images' : data['images'],
      'title': data['title'],
      'content': data['content'],
      'address': data['address'],
      'deposit': data['deposit'],
      'rent': data['rent'],
      'maintenanceFeeIncluded': data['maintenanceFeeIncluded'],
      'moveInDate': data['moveInDate'],
      'expirationDate': data['expirationDate'],
      'door': data['door'],
      'floor': data['floor'],
      'roomCount': data['roomCount'],
      'windowDirection': data['windowDirection'],
      'isSold': data['isSold'],
      'userId': data['userId'],
      'userImage': data['userImage'],
      'nickname': data['nickname'],
    }).map((data) => Map<String, dynamic>.from(data)).cast<Map<String, dynamic>>().toList();

    print(data);
    return data;

  }on DioException catch(e){
    print(e.message);
    return [];
  }

}
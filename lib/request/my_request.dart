import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:knu_homes/riverpod_provider/house_reg_provider.dart';

final dio = Dio();

final String baseUrl = 'http://kkym.duckdns.org:8080';

void postHouseDetail(
  HouseRegState houseRegState,
  String gate,
  String windowDirection,
  bool maintenceFeeIncluded,
  int roomCnt,
  int floor,
  int montlyFee,
  int deposit,
  String moveIn,
  String moveOut,
) async {
  final request = ItemEnrollRequest(
    title: houseRegState.title,
    content: houseRegState.detailInfo,
    address: houseRegState.buildingAddress,
    deposit: deposit,
    rent: montlyFee,
    maintenanceFeeIncluded: maintenceFeeIncluded,
    moveInDate: moveIn,
    expirationDate: moveOut,
    door: gate,
    floor: floor,
    roomCount: roomCnt,
    windowDirection: windowDirection,
    images: houseRegState.imageList.map((image) {
      return MultipartFile.fromFileSync(image.path, filename: image.path.split('/').last, contentType: DioMediaType.parse('image/jpeg'));
    }).toList(),
  );

  try {
    String my_token =
        "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6Imdva2l5ZW9ubWluIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE3MjY4OTQxNzIsImV4cCI6MTczMjA3ODE3Mn0.cmE1CrdXqg7V8I3vWuVSjWv1_O1FQSI4mFVQV1aT1hEY05PFcHmb3ckVFPIE4cfuxtpT5a-L5EHGqrKubpxorw";

    // final data = FormData.fromMap(request.toMap());
    final resp = await dio.post(
      '$baseUrl/api/items',
      data: FormData.fromMap({
        'itemEnrollRequest': jsonEncode(request.item()),
        'images': null,
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $my_token', // 토큰 추가
        },
        contentType: 'application/json',
      ),
    );

    final resp2 = await dio.post(
      '$baseUrl/api/items',
      data: FormData.fromMap({
        'images': request.images,
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $my_token', // 토큰 추가
        },
        contentType: 'multipart/form-data',
      ),
    );

    if (resp.statusCode == 201 && resp2.statusCode == 201) {
      print('매물 등록 성공: ${resp.data}');
    } else {
      if(resp.statusCode != 201) {
        print('매물 등록(json) 실패: ${resp.data}');
      }else if(resp2.statusCode != 201){
        print('매물 등록(이미지) 실패: ${resp2.data}');
      }
    }
  } on DioException catch (e) {
    print('오류 발생: ${e.response}');
  }
}

class ItemEnrollRequest {
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
  final List<MultipartFile> images;

  ItemEnrollRequest({
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
  });

  Map<String, dynamic> item() {
    return {
      'title': title,
      'content': content,
      'address': address,
      'deposit': deposit,
      'rent': rent,
      'maintenanceFeeIncluded': maintenanceFeeIncluded,
      'moveInDate': moveInDate,
      'expirationDate': expirationDate,
      'door': door,
      'floor': floor,
      'roomCount': roomCount,
      'windowDirection': windowDirection,
    };
  }

  // toJson 메서드 추가
  Map<String, dynamic> toMap() {
    Map<String, dynamic> temp = {
      'itemEnrollRequest': jsonEncode({
        'title': title,
        'content': content,
        'address': address,
        'deposit': deposit,
        'rent': rent,
        'maintenanceFeeIncluded': maintenanceFeeIncluded,
        'moveInDate': moveInDate,
        'expirationDate': expirationDate,
        'door': door,
        'floor': floor,
        'roomCount': roomCount,
        'windowDirection': windowDirection,
      }),
      'images': images,
    };

    print("temp: ${temp.toString()}");
    return temp;
  }
}

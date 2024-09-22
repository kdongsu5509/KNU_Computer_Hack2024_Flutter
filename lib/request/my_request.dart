import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:knu_homes/riverpod_provider/house_reg_provider.dart';

import '../a_server_info/server_url.dart';

final dio = Dio();

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
  BuildContext context,
) async {
  final request = ItemEnrollRequest(
    title: houseRegState.title,
    content: houseRegState.detailInfo,
    address: houseRegState.buildingAddress,
    name : houseRegState.buildingName,
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
      return MultipartFile.fromFileSync(image.path,
          filename: image.path.split('/').last,
          contentType: DioMediaType.parse('image/jpeg'));
    }).toList(),
  );

  try {
    String my_token =
        "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6Imdva2l5ZW9ubWluIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE3MjY4OTQxNzIsImV4cCI6MTczMjA3ODE3Mn0.cmE1CrdXqg7V8I3vWuVSjWv1_O1FQSI4mFVQV1aT1hEY05PFcHmb3ckVFPIE4cfuxtpT5a-L5EHGqrKubpxorw";

    // final data = FormData.fromMap(request.toMap());
    final resp = await dio.post(
      '$baseUrl/api/items',
      data: request.item(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $my_token', // 토큰 추가
        },
        contentType: 'application/json',
      ),
    );

    // final resp2 = await dio.post(
    //   '$baseUrl/api/items',
    //   data: FormData.fromMap({
    //     'images': request.images,
    //   }),
    //   options: Options(
    //     headers: {
    //       'Authorization': 'Bearer $my_token', // 토큰 추가
    //     },
    //     contentType: 'multipart/form-data',
    //   ),
    // );

    if (resp.statusCode == 201) {
      print('매물 등록 성공: ${resp.data}');

      try {
        final resp2 = await dio.post(
          '$baseUrl/api/items/${resp.data['id']}/images',
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

        if(resp2.statusCode!.toInt() >= 200 && resp2.statusCode!.toInt()< 300) {
          Navigator.of(context).pop();
          //차후에 provider 삭제하는 코드 추가
        } else {
          print('매물 등록(이미지) 실패: ${resp2.data}');
        }
      } on DioException catch (e) {
        print('오류 발생: ${e.response}');
      }
    } else {
      print('매물 등록(이미지) 실패: ${resp.data}');
    }
  } on DioException catch (e) {
    print('오류 발생: ${e.response}');
  }
}

class ItemEnrollRequest {
  final String title;
  final String content;
  final String address;
  final String name;
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
    required this.name,
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
      'name': name,
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
        'name': name,
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

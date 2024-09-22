import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knu_homes/main_service/chatting/chatting_list_detail.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/user/view/signup/usr_signup_a.dart';
import 'package:knu_homes/user/view/usr_login.dart';

import '../a_server_info/server_url.dart';
import '../const/MyColor.dart';
import '../project_common/customDivider.dart';
import '../request/houser_list_request.dart';
import '../riverpod_provider/user_info_provider.dart';
import 'chatting/chatting_list.dart';

class HouseDetail extends ConsumerStatefulWidget {
  final int houseId;

  HouseDetail({
    required this.houseId,
    super.key,
  });

  @override
  ConsumerState<HouseDetail> createState() => _HouseRegState();
}

class _HouseRegState extends ConsumerState<HouseDetail> {
  List<File> _imageList = [];

  Future<Map<String, dynamic>> _fetchHouseDetail() async {
    return await HouseDetailRequest(id: widget.houseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _fetchHouseDetail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터를 불러오는 동안 로딩 스피너를 표시합니다.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // 에러가 발생했을 때
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // 데이터를 성공적으로 불러온 경우
                final detailInfo = snapshot.data!;

                return Padding(
                  padding: EdgeInsets.all(myFWidth(context, 0.04)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          width: myFWidth(context, 0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('작성일: ${detailInfo['createdAt']}', style: TextStyle(fontSize: myFWidth(context, 0.04))),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myFWidth(context, 0.05)),
                            child: Text(
                              detailInfo['title'],
                              style: TextStyle(
                                fontSize: myFWidth(context, 0.06),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ChattingList(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: myFWidth(context, 0.05)),
                                child: Icon(
                                  Icons.send,
                                  color: MY_BLUE,
                                ),
                              )),
                        ],
                      ), // 글 제목
                      CustomDivider(
                          context: context, indent: 0.04, thickness: 0.002),
                      // _imageListWidget(detailInfo['images']), // 이미지 리스트
                      // Image.network(detailInfo['images'][0]),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: myFWidth(context, 0.05)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.from(
                                detailInfo['images'].map((url) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(myFWidth(context, 0.05)),
                                child: Image.network(url,
                                    width: myFWidth(context, 0.5)),
                              );
                            }).toList()),
                          ),
                        ),
                      ),
                      // Column(
                      //   children: detailInfo['images'].map((url) {
                      //     print(url);
                      //     return Image.network(url) ;
                      //   }).toList(),
                      // ),
                      SizedBox(
                        height: myFHeight(context, 0.3),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _imageList.length ?? 1,
                          itemBuilder: (context, index) {
                            return Image.file(_imageList[index]);
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: myFHeight(context, 0.3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            detailInfo['content'],
                            style: TextStyle(
                              fontSize: myFWidth(context, 0.04),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: myFHeight(context, 0.05)),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              Text('주소: ${detailInfo['address'] ?? ''}')), // 주소
                      TextButton(
                        onPressed: () async {
                          try {
                            final dio = Dio();
                            late final chatRoomId;

                            final resp =
                                await dio.post(baseUrl + '/api/chat/rooms',
                                    data: {
                                      'itemId': widget.houseId,
                                    }, //채팅방 id 조회
                                    options: Options(headers: {
                                      'Authorization': 'Bearer $MY_TOKEN',
                                    }));

                            chatRoomId =
                                resp.data['chatRoomId'].toInt(); //채팅방 id

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChattingListDetail(
                                  chatRoomId: chatRoomId,
                                ),
                              ),
                            );
                          } on DioException catch (e) {
                            print('오류 발생: ${e.response?.statusCode}');

                            if (e.response!.statusCode == 401) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsrLogin()),
                              );
                            } else {
                              print('오류 발생: ${e.response}');
                            }
                          }
                        },
                        child: Text('채팅하기'),
                      ),
                    ],
                  ),
                );
              } else {
                // 데이터가 없는 경우
                return Text('No Data Available');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _imageListWidget(
    List<String> _imageList,
  ) {
    List<Image> imageList = [];

    _imageList.forEach((url) {
      imageList.add(
        Image.network(url),
      );
    });

    return Column(
      children: imageList,
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile>? pickedImages =
        await picker.pickMultiImage(); // 다중 이미지 선택
    if (pickedImages != null) {
      setState(() {
        _imageList = pickedImages
            .map((pickedImage) => File(pickedImage.path))
            .toList(); // 선택한 이미지 리스트로 변환
      });
    }
  }
}

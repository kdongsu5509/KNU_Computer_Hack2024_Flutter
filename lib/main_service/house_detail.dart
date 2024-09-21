import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../project_common/customDivider.dart';
import '../request/houser_list_request.dart';

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

  Future<List<Map<String, dynamic>>> _fetchHouseDetail() async {
    return await HouseDetailRequest(id: widget.houseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Map<String, dynamic>>>(
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
                print(detailInfo);
                return Column(
                  children: [
                    Text('사용자 프로필'),
                    Text('글 제목: ${detailInfo[0]['title'] ?? ''}'), // 글 제목
                    CustomDivider(context: context, indent: 0.04, thickness: 0.002),
                    Text('사진 좌우 스크롤 위젯'),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageList.length ?? 1,
                        itemBuilder: (context, index) {
                          return Image.file(_imageList[index]);
                        },
                      ),
                    ),
                    Text('건물명: ${detailInfo[0]['buildingName'] ?? ''}'), // 건물명
                    Text('주소: ${detailInfo[0]['address'] ?? ''}'), // 주소
                  ],
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

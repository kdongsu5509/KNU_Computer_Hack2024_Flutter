import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knu_homes/project_common/filter/filter_single_slider_tile.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/user/common/user_text_input_box.dart';
import '../project_common/customDivider.dart';
import '../project_common/filter/filter_calendar_tile.dart';
import '../project_common/filter/filter_tile.dart';

class HouseDetail extends ConsumerStatefulWidget {
  const HouseDetail({super.key});

  @override
  ConsumerState<HouseDetail> createState() => _HouseRegState();
}

class _HouseRegState extends ConsumerState<HouseDetail> {
  List<File> _imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '글쓰기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDivider(context: context, indent: 0.04, thickness: 0.002),
              UserTextInputBox(hintText: ' 제목을 입력하세요'),
              UserTextInputBox(
                  hintText:
                  ' 홈즈에 올릴 게시글 내용을 작성해주세요.\n 신뢰할 수 있는 거래를 위해 자세히 적어주세요\n',
                  isNeedLong: true),
              UserTextInputBox(hintText: ' 매물 이름을 입력하세요'),
              UserTextInputBox(hintText: ' 매물 주소를 입력하세요'),
              // 이미지 선택 부분
              Container(
                height: MediaQuery.of(context).size.width * 0.32,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _imageList.length + 1, // 이미지 리스트의 길이 + 추가 버튼
                  itemBuilder: (context, index) {
                    if (index < _imageList.length) {
                      return Padding(
                        padding: EdgeInsets.all(
                          myFWidth(context, 0.04),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(_imageList[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: _pickImages, // 이미지 선택 함수 호출
                        child: Padding(
                          padding: EdgeInsets.all(
                            myFWidth(context, 0.04),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.add_a_photo, size: 40),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),

              // 필터 및 기타 UI 요소
              FilterTile(
                filterName: '문위치',
                filterElements: ['정문', '북문', '서문', '테크노문', '동문'],
                providerName: 'gateProvider',
              ),
              FilterTile(
                filterName: '관리비 포함 여부',
                filterElements: ['포함', '별도', '기타'],
                providerName: 'maintenceBillProvider',
              ),
              FilterTile(
                filterName: '창문 방향',
                filterElements: ['남향', '동향', '서향', '북향'],
                providerName: 'windowDirectionProvider',
              ),
              FilterTile(
                filterName: '방 개수',
                filterElements: ['원룸', '투룸', '쓰리룸+'],
                providerName: 'roomCntProvider',
              ),
              FilterTile(
                filterName: '층 안내',
                filterElements: ['1층', '2층', '3층', '4층', '5층+'],
                providerName: 'roomFloorProvider',
                isDivide: true,
              ),
              FiltersSingleSidertile(
                filterName: '월세',
              ),
              FiltersSingleSidertile(
                filterName: '보증금',
              ),
              FilterCalendarTile(filterName: '입주 가능 날짜'),
              FilterCalendarTile(filterName: '계약 만료 날짜'),
            ],
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

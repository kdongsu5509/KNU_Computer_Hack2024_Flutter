import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knu_homes/project_common/filter/filter_single_slider_tile.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/user/common/user_login_register_button.dart';
import 'package:knu_homes/user/common/user_text_input_box.dart';
import '../project_common/customDivider.dart';
import '../project_common/filter/filter_calendar_tile.dart';
import '../project_common/filter/filter_tile.dart';
import '../project_common/filter/filter_title.dart';
import '../request/my_request.dart';
import '../riverpod_provider/filter_provider.dart';
import '../riverpod_provider/house_reg_provider.dart';
import '../riverpod_provider/user_info_provider.dart';

class HouseReg extends ConsumerStatefulWidget {
  const HouseReg({super.key});

  @override
  ConsumerState<HouseReg> createState() => _HouseRegState();
}

class _HouseRegState extends ConsumerState<HouseReg> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailInfoController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider의 초기값 설정
    titleController.addListener(() {
      ref.read(houseRegProvider.notifier).updateTitle(titleController.text);
    });
    detailInfoController.addListener(() {
      ref.read(houseRegProvider.notifier).updateDetailInfo(detailInfoController.text);
    });
    buildingNameController.addListener(() {
      ref.read(houseRegProvider.notifier).updateBuildingName(buildingNameController.text);
    });
    buildingAddressController.addListener(() {
      ref.read(houseRegProvider.notifier).updateBuildingAddress(buildingAddressController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gateMapper = Map.from({
      0: 'MAIN',
      1: 'NORTH',
      2: 'WEST',
      3: 'TECHNO',
      4: 'SOUTH',
    });

    final windowDirectionMapper = Map.from({
      0: 'SOUTH',
      1: 'EAST',
      2: 'WEST',
      3: 'NORTH',
    });

    final houseRegState = ref.watch(houseRegProvider);
    final token = ref.watch(tokenProvider);
    final gate = ref.watch(gateProvider);
    final maintenceBill = ref.watch(maintenceBillProvider);
    final windowDirection = ref.watch(windowDirectionProvider);
    final roomCnt = ref.watch(roomCntProvider);
    final roomFloor = ref.watch(roomFloorProvider);
    final monthlyFee = ref.watch(monthlyFeeProvider);
    final deposit = ref.watch(depositValueProvider);
    final moveInDate = ref.watch(moveInDateProvider);
    final moveOutDate = ref.watch(moveOutDateProvider);
    final isAgree = ref.watch(isAgreeProvider);

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
              UserTextInputBox(
                hintText: ' 제목을 입력하세요',
                controller: titleController,
              ),
              UserTextInputBox(
                hintText: ' 홈즈에 올릴 게시글 내용을 작성해주세요.\n 신뢰할 수 있는 거래를 위해 자세히 적어주세요\n',
                isNeedLong: true,
                controller: detailInfoController,
              ),
              UserTextInputBox(
                hintText: ' 매물 이름을 입력하세요',
                controller: buildingNameController,
              ),
              UserTextInputBox(
                hintText: ' 매물 주소를 입력하세요',
                controller: buildingAddressController,
              ),
              // 이미지 선택 부분
              Container(
                height: MediaQuery.of(context).size.width * 0.32,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: houseRegState.imageList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < houseRegState.imageList.length) {
                      return Padding(
                        padding: EdgeInsets.all(myFWidth(context, 0.04)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(houseRegState.imageList[index].path)), // XFile을 File로 변환
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: _pickImages,
                        child: Padding(
                          padding: EdgeInsets.all(myFWidth(context, 0.04)),
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
              FiltersSingleSidertile(filterName: '월세'),
              FiltersSingleSidertile(filterName: '보증금'),
              FilterCalendarTile(filterName: '입주 가능 날짜'),
              FilterCalendarTile(filterName: '계약 만료 날짜'),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    value: houseRegState.isAgree,
                    onChanged: (bool? newValue) {
                      if (newValue != null) {
                        ref.read(houseRegProvider.notifier).updateIsAgree(newValue);
                      }
                    },
                  ),
                  FilterTitle(
                    filterName: '이 모든 항목은 서류상 집주인과 합의되었으며\n이후 발생하는 모든 문제는 홈즈에서 책임지지 \n않음을 동의합니다.',
                    fontSize: 0.03,
                  ),
                ],
              ),
              SizedBox(height: myFWidth(context, 0.04)),
              UserLoginRegisterButton(
                buttonText: '등록하기',
                onPressed: () {
                  postHouseDetail(
                    houseRegState,
                    gateMapper[gate],
                    windowDirectionMapper[windowDirection],
                    true, // 임시로 true로 설정
                    roomCnt!,
                    roomFloor!,
                    monthlyFee.toInt()!,
                    deposit.toInt()!,
                    moveInDate,
                    moveOutDate,
                    context,
                  );

                  // Provider 값 초기화
                  ref.read(gateProvider.notifier).update((state) => null);
                  ref.read(maintenceBillProvider.notifier).update((state) => null);
                  ref.read(windowDirectionProvider.notifier).update((state) => null);
                  ref.read(roomCntProvider.notifier).update((state) => null);
                  ref.read(roomFloorProvider.notifier).update((state) => null);
                  ref.read(monthlyFeeProvider.notifier).update((state) => 0.0);
                  ref.read(depositValueProvider.notifier).update((state) => 0.0);
                  ref.read(moveInDateProvider.notifier).update((state) => 'YYYY/MM/DD');
                  ref.read(moveOutDateProvider.notifier).update((state) => 'YYYY/MM/DD');
                  ref.read(isAgreeProvider.notifier).update((state) => false);
                },
              ),


              SizedBox(height: myFWidth(context, 0.04)),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile>? imageFiles = await picker.pickMultiImage();

    if (imageFiles != null) {
      // final newImages = multipartFiles.map((pickedImage) => File(pickedImage.path)).toList();
      ref.read(houseRegProvider.notifier).updateImageList(imageFiles);
    }
  }
}

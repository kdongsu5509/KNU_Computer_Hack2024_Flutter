import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/main_service/house_reg.dart';
import 'package:knu_homes/main_service/my_page/my_page_main.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/project_common/selector_bean/selectorBean_justshow.dart';
import '../project_common/house_summarize_tile.dart';
import '../request/houser_list_request.dart';
import '../riverpod_provider/filter_provider.dart';
import 'house_list_component/my_drawer.dart';

class HouseList extends ConsumerStatefulWidget {
  const HouseList({super.key});

  @override
  ConsumerState<HouseList> createState() => _HouseListState();
}

class _HouseListState extends ConsumerState<HouseList> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Map<String, dynamic>>> houseList;

  @override
  void initState() {
    super.initState();
    houseList = HouseListRequest();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more items if needed
        houseList = HouseListRequest();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    // 데이터 새로 고침 로직
    setState(() {
      houseList = HouseListRequest(); // 새로 고침 시 새로운 데이터 요청
    });
  }

  @override
  Widget build(BuildContext context) {
    final gateValue = ref.watch(gateProvider);
    final maintenBillValue = ref.watch(maintenceBillProvider);
    final windowValue = ref.watch(windowDirectionProvider);
    final roomCntValue = ref.watch(roomCntProvider);
    final roomFloorValue = ref.watch(roomFloorProvider);
    final monthlyFeeStartValue = ref.watch(monthlyFeeStartValueProvider);
    final monthlyFeeEndValue = ref.watch(monthlyFeeEndValueProvider);
    final depositStartValue = ref.watch(depositStartValueProvider);
    final depositEndValue = ref.watch(depositEndValueProvider);
    final moveInDateValue = ref.watch(moveInDateProvider);

    bool isFilterApplied = checkOptionValue(
        gateValue, maintenBillValue, windowValue, roomCntValue, roomFloorValue,
        monthlyFeeStartValue: monthlyFeeStartValue,
        monthlyFeeEndValue: monthlyFeeEndValue,
        depositStartValue: depositStartValue,
        depositEndValue: depositEndValue,
        moveInDateValue: moveInDateValue);

    return FutureBuilder(
      future: houseList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _myAppBar(context), // 커스텀 AppBar
            drawer: MyDrawer(context: context), // 커스텀 Drawer
            body: RefreshIndicator(
              onRefresh: _refreshData, // 리프레시 시 호출되는 메서드
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: myFWidth(context, 0.025),
                      ),
                      _pageTop(context: context),
                      _myDivider(context),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return houseSummarizeTile(context, false, snapshot.data![index]);
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(myFWidth(context, 0.03)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HouseReg()), // HouseReg으로 이동
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MY_BLUE,
                            borderRadius:
                            BorderRadius.circular(myFHeight(context, 0.03)),
                          ),
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                            size: myFHeight(context, 0.05),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return SizedBox(
          width: myFWidth(context, 0.3),
          child: Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }
}


bool checkOptionValue(int? gateValue, int? maintenBillValue, int? windowValue,
    int? roomCntValue, int? roomFloorValue,
    {required double monthlyFeeStartValue,
    required double monthlyFeeEndValue,
    required double depositStartValue,
    required double depositEndValue,
    required String moveInDateValue}) {
  if (gateValue != null &&
      maintenBillValue != null &&
      windowValue != null &&
      roomCntValue != null &&
      roomFloorValue != null &&
      monthlyFeeStartValue != 0 &&
      monthlyFeeEndValue != 100 &&
      depositStartValue != 0 &&
      depositEndValue != 1000 &&
      moveInDateValue != 'YYYY/MM/DD') {
    return false;
  }
  return true;
}

PreferredSizeWidget? _myAppBar(BuildContext context) {
  double iconSize = MediaQuery.of(context).size.height * 0.04;
  return AppBar(
    backgroundColor: Colors.white,
    leading: Builder(
      // Builder로 새로운 context 생성
      builder: (context) => IconButton(
        icon: Icon(Icons.menu, size: iconSize),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Drawer 열기
        },
      ),
    ),
    title: Row(
      children: [
        SizedBox(
          width: myFWidth(context, 0.69),
        ),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MyPageMain()), // UsrLogin으로 이동
              );
            },
            child: Icon(Icons.person_2_outlined, size: iconSize)),
      ],
    ),
  );
}

Widget _pageTop({
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      myFWidth(context, 0.06),
      myFWidth(context, 0.015),
      myFWidth(context, 0.06),
      myFWidth(context, 0.045),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: MY_BLUE,
        borderRadius: BorderRadius.circular(myFHeight(context, 0.03)),
      ),
      height: myFHeight(context, 0.15),
      child: Center(
        child: Text(
          '당신에게 \n 딱 맞는 집을 찾아보세요!',
          style: TextStyle(
            fontSize: myFWidth(context, 0.06),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget _myDivider(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: myFWidth(context, 0.03),
    ),
    child: Divider(
      color: Colors.black,
      thickness: myFHeight(context, 0.0035),
      endIndent: myFWidth(context, 0.015),
    ),
  );
}

DropdownMenuItem onChanged(String? value) {
  return DropdownMenuItem(
    value: value,
    child: Text(value!),
  );
}

Widget _showCheckedOption({
  required BuildContext context,
  required int? gateValue,
  required int? maintenBillValue,
  required int? windowValue,
  required int? roomCntValue,
  required int? roomFloorValue,
  required double monthlyFeeStartValue,
  required double monthlyFeeEndValue,
  required double depositStartValue,
  required double depositEndValue,
  required String moveInDateValue,
}) {
  List<Widget> appliedFilters = [];

  if (gateValue != null) {
    Map<int, String> gateMap = {0: '정문', 1: '북문', 2: '서문', 3: '테크노문', 4: '동문'};
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '문: ${gateMap[gateValue]}',
        provider: gateProvider,
        type: 0));
  }
  if (maintenBillValue != null) {
    Map<int, String> maintenBillMap = {0: '포함', 1: '별도', 2: '기타'};
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '관리비: ${maintenBillMap[maintenBillValue]}',
        provider: maintenceBillProvider,
        type: 0));
  }
  if (windowValue != null) {
    Map<int, String> windowMap = {0: '남향', 1: '동향', 2: '서향', 3: '북향'};
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '창문: ${windowMap[windowValue]}',
        provider: windowDirectionProvider,
        type: 0));
  }
  if (roomCntValue != null) {
    Map<int, String> roomCntMap = {0: '원룸', 1: '투룸', 2: '쓰리룸+'};
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '방 개수: ${roomCntMap[roomCntValue]}',
        provider: roomCntProvider,
        type: 0));
  }
  if (roomFloorValue != null) {
    Map<int, String> roomFloorMap = {
      0: '1층',
      1: '2층',
      2: '3층',
      3: '4층',
      4: '5층+'
    };
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '층수: ${roomFloorMap[roomFloorValue]}',
        provider: roomFloorProvider,
        type: 0));
  }
  if (monthlyFeeStartValue != 0 || monthlyFeeEndValue != 100) {
    appliedFilters.add(SelectorBeanJustShow(
        selectorName:
            '월세: ${monthlyFeeStartValue.toInt()} ~ ${monthlyFeeEndValue.toInt()}',
        provider: monthlyFeeStartValueProvider,
        type: 1,
        provider2: monthlyFeeEndValueProvider));
  }
  if (depositStartValue != 0 || depositEndValue != 1000) {
    appliedFilters.add(SelectorBeanJustShow(
        selectorName:
            '보증금: ${depositStartValue.toInt()} ~ ${depositEndValue.toInt()}',
        provider: depositStartValueProvider,
        type: 2,
        provider2: depositEndValueProvider));
  }
  if (moveInDateValue.compareTo('YYYY/MM/DD') != 0) {
    appliedFilters.add(SelectorBeanJustShow(
        selectorName: '입주 가능일: $moveInDateValue',
        provider: moveInDateProvider,
        type: 3));
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: myFWidth(context, 0.04)),
    child: Wrap(
      spacing: myFWidth(context, 0.02),
      runSpacing: myFHeight(context, 0.01),
      children: appliedFilters,
    ),
  );
}


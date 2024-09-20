import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/filter/filter_calendar_tile.dart';
import 'package:knu_homes/project_common/filter/filter_slider_tile.dart';
import '../../const/MyColor.dart';
import '../../project_common/filter/filter_tile.dart';
import '../../project_common/reactSize.dart';
import '../../riverpod_provider/filter_provider.dart';
import '../../project_common/filter/filter_title.dart';
import '../my_page/my_page_main.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({required BuildContext context, super.key});

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final finishContainValue = ref.watch(finishContainProvider);

    return Drawer(
      backgroundColor: MY_IVORY,
      child: ListView(
        children: [
          SizedBox(height: myFHeight(context, 0.02)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyPageMain()), // MyPage로 이동
              );
            },
            child: _myDrawerTop(
              context: context,
              iconName: '마이페이지',
              icon:
                  Icon(Icons.person_2_outlined, size: myFHeight(context, 0.035)),
            ),
          ),
          _myDrawerTop(
            context: context,
            iconName: '채팅목록',
            icon: Icon(Icons.messenger_outline_outlined,
                size: myFHeight(context, 0.035)),
          ),
          Divider(
            color: Colors.black,
            thickness: myFHeight(context, 0.002),
            indent: myFWidth(context, 0.03),
            endIndent: myFWidth(context, 0.03),
          ),
          FilterTitle(filterName: '검색필터', isLonely: true),
          SizedBox(height: myFHeight(context, 0.015)),
          Row(
            children: [
              Checkbox(
                activeColor: Colors.black,
                checkColor: Colors.white,
                value: finishContainValue,
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    // 새로운 상태를 반환하는 함수 형태로 전달
                    ref
                        .read(finishContainProvider.notifier)
                        .update((state) => newValue);
                    print(
                        'finishContainValue: ${!finishContainValue}'); // 선택 시 false, 선택 해제 시 true
                  }
                },
              ),
              FilterTitle(filterName: '거래완료매물 포함', fontSize: 0.038),
            ],
          ),
          FilterTile(
            filterName: '문위치',
            filterElements: [
              '정문',
              '북문',
              '서문',
              '테크노문',
              '동문',
            ],
            providerName: 'gateProvider',
            isDivide: true,
          ),
          FilterTile(
            filterName: '관리비 포함 여부',
            filterElements: [
              '포함',
              '별도',
              '기타',
            ],
            providerName: 'maintenceBillProvider',
          ),
          FilterTile(
            filterName: '창문 방향',
            filterElements: ['남향', '동향', '서향', '북향'],
            providerName: 'windowDirectionProvider',
          ),
          FilterTile(
            filterName: '방 개수',
            filterElements: [
              '원룸',
              '투룸',
              '쓰리룸+',
            ],
            providerName: 'roomCntProvider',
          ),
          FilterTile(
            filterName: '층 안내',
            filterElements: ['1층', '2층', '3층', '4층', '5층+'],
            providerName: 'roomFloorProvider',
            isDivide: true,
          ),
          Filterslidertile(
            filterName: '월세',
          ),
          Filterslidertile(
            filterName: '보증금',
          ),
          FilterCalendarTile(filterName: '입주 가능 날짜'),
          SizedBox(height: myFHeight(context, 0.05)),
        ],
      ),
    );
  }
}

Widget _myDrawerTop({
  required BuildContext context,
  required String iconName,
  required Icon icon,
}) {
  return Container(
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(myFWidth(context, 0.03)),
          child: icon,
        ),
        Text(
          iconName,
          style: TextStyle(
            fontSize: myFHeight(context, 0.023),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

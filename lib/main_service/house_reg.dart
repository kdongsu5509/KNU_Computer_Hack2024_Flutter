import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/my_page/my_page_edit_and_secession.dart';

import '../project_common/customDivider.dart';
import '../project_common/filter/filter_calendar_tile.dart';
import '../project_common/filter/filter_slider_tile.dart';
import '../project_common/filter/filter_tile.dart';
import '../project_common/page_title_box.dart';
import '../user/common/user_info_input_box.dart';
import '../user/common/user_login_register_button.dart';

class HouseReg extends StatelessWidget {
  const HouseReg({super.key});

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
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomDivider(context: context, indent: 0.04, thickness: 0.002),
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
            ],
          ),
        ),
      ),
    );
  }
}

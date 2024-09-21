import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/customDivider.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import '../../const/MyColor.dart';
import '../../project_common/house_summarize_tile.dart';
import 'my_page_edit.dart';

class MyPageMain extends ConsumerWidget {
  const MyPageMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CustomDivider(context: context, indent: 0.04),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: myFWidth(context, 0.04)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_UserProfile(context), _MySell(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _UserProfile(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        myFWidth(context, 0.04),
        myFWidth(context, 0.06),
        myFWidth(context, 0.04),
        myFWidth(context, 0.1)),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MY_GREY,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(),
          ),
          child: Icon(
            Icons.person_add_outlined,
            size: myFWidth(context, 0.23),
          ),
        ),
        SizedBox(width: myFWidth(context, 0.03)), // 공간 추가
        Expanded(
          // Row 안의 Column을 Expanded로 감싸서 공간을 차지하도록 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Name',
                style: TextStyle(
                  fontSize: myFWidth(context, 0.05),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '아이디',
                    style: TextStyle(
                      fontSize: myFWidth(context, 0.04),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPageEdit(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.mode_edit_outline_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _MySell(
    BuildContext context,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          SizedBox(width: myFWidth(context, 0.1)),
          Text('My Sell',
              style: TextStyle(
                  fontSize: myFWidth(context, 0.05),
                  fontWeight: FontWeight.bold)),
        ],
      ),
      CustomDivider(context: context, indent: 0.0, thickness: 0.002),
      SizedBox(height: myFWidth(context, 0.05)),
      houseSummarizeTile(context, false, {
        'title': '아파트 이름',
        'content': '아파트 내용',
      }),
    ],
  );
}
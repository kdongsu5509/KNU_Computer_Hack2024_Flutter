import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/main_service/my_page/my_page_edit_and_secession.dart';
import 'package:knu_homes/project_common/customDivider.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import '../../a_server_info/server_url.dart';
import '../../const/MyColor.dart';
import '../../project_common/house_summarize_tile.dart';
import '../../riverpod_provider/user_info_provider.dart';
import '../../user/view/usr_login.dart';
import 'my_page_edit.dart';

class MyPageMain extends ConsumerStatefulWidget {
  const MyPageMain({super.key});

  @override
  ConsumerState<MyPageMain> createState() => _MyPageMainState();
}

class _MyPageMainState extends ConsumerState<MyPageMain> {
  final dio = Dio();
  Map<String, dynamic> _myInfo = {};
  String _userPicture = basePic; // 사용자 정보 저장할 변수
  List<dynamic> _mySellInfo = []; // 판매 정보 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchMyInfo(); // 사용자 정보 요청
    _getUserProfile(); // 사용자 프로필 이미지 요청
    _fetchMySellInfo(); // 판매 정보 요청
  }

  // 사용자 정보 요청하는 메서드
  void _fetchMyInfo() async {
    try {
      final response = await dio.get(
        '$baseUrl/api/users',
        options: Options(headers: {
          'Authorization': 'Bearer $MY_TOKEN',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _myInfo = response.data; // 서버에서 받은 사용자 데이터 저장
        });
      } else {
        print('Failed to load user info');
      }
    } on DioException catch (e) {
      print('Error: $e');
    }
  }

  // 판매 정보 요청하는 메서드
  void _fetchMySellInfo() async {
    try {
      final response = await dio.get(
        '$baseUrl/api/users/sell', // 판매 정보 URL을 설정하세요
        options: Options(headers: {
          'Authorization': 'Bearer $MY_TOKEN',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _mySellInfo = response.data; // 서버에서 받은 판매 데이터 저장
        });
      } else {
        print('Failed to load sell info');
      }
    } on DioException catch (e) {
      print('Error: $e');
    }
  }

  void _getUserProfile() async {
    try {
      final response = await dio.get(
        '$baseUrl/api/users/image',
        options: Options(headers: {
          'Authorization': 'Bearer $MY_TOKEN',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          if (response.data['url'] != null)
            _userPicture = response.data['url']; // 프로필 이미지 URL 저장
          else
            _userPicture = basePic;
        });
      } else {
        print('Failed to load user profile image');
        setState(() {
          _userPicture = basePic;
        });
      }
    } on DioException catch (e) {
      setState(() {
        _userPicture = basePic;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  _UserProfile(context, _myInfo), // 사용자 정보 UI에 반영
                  if (_userPicture.isNotEmpty)
                    _MySell(context, _mySellInfo), // 판매 정보를 UI에 반영
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 판매 정보를 표시하는 위젯
Widget _MySell(BuildContext context, List<dynamic> mySellInfo) {
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
      ...mySellInfo.map((item) {
        return houseSummarizeTile(context, false, {
          'title': item['title'], // 판매 항목의 제목
          'content': item['content'], // 판매 항목의 내용
        });
      }).toList(),
    ],
  );
}


Widget _UserProfile(BuildContext context, Map<String, dynamic> userInfo) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        myFWidth(context, 0.04),
        myFWidth(context, 0.06),
        myFWidth(context, 0.04),
        myFWidth(context, 0.1)),
    child: Row(
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MY_GREY,
              // borderRadius: BorderRadius.circular(100),
              border: Border.all(),
            ),
            child: Image.network(
              basePic,
              width: myFWidth(context, 0.23),
            ),
          ),
        ),
        SizedBox(width: myFWidth(context, 0.03)), // 공간 추가
        Expanded(
          // Row 안의 Column을 Expanded로 감싸서 공간을 차지하도록 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo['nickname'] ?? '방문자', // 닉네임 표시 (없으면 기본값)
                style: TextStyle(
                  fontSize: myFWidth(context, 0.05),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userInfo['username'] ?? '[현재 미로그인 상태]',
                    // 유저 아이디 표시 (없으면 기본값)
                    style: TextStyle(
                      fontSize: myFWidth(context, 0.04),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPageEditAndSecession(),
                        ),
                      );
                    },
                    child: (userInfo['username'] != null)
                        ? Icon(
                            Icons.mode_edit_outline_outlined,
                          )
                        : Container(),
                  ),
                ],
              ),
              (userInfo['username'] == null)
                  ? TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsrLogin()),
                        );
                      },
                      child: Text('로그인 하러 가기'),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}
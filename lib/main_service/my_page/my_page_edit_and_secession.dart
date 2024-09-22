import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/house_list.dart';
import 'package:knu_homes/main_service/my_page/my_page_main.dart';
import 'package:knu_homes/main_service/my_page/my_page_secession.dart';
import 'package:dio/dio.dart';

import '../../a_server_info/server_url.dart';
import '../../project_common/customDivider.dart';
import '../../riverpod_provider/user_info_provider.dart';
import '../../user/common/user_info_input_box.dart';
import '../../user/common/user_login_register_button.dart';

class MyPageEditAndSecession extends StatefulWidget {
  const MyPageEditAndSecession({super.key});

  @override
  _MyPageEditAndSecessionState createState() => _MyPageEditAndSecessionState();
}

class _MyPageEditAndSecessionState extends State<MyPageEditAndSecession> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();


  Future<void> _updateNickname() async {
    final String url = '$baseUrl/api/users'; // 닉네임 업데이트 URL
    final Dio dio = Dio();

    try {
      final response = await dio.put(
        url,
        data: {
          'nickname': nicknameController.text,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $MY_TOKEN',
        }),
      );

      // 반환값은 무시할 예정
    } on DioException catch (e) {
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
          'Edit/Secession',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDivider(context: context, indent: 0.04),
              SizedBox(height: MediaQuery.of(context).size.height * 0.35),
              UserInfoInputBox(
                labelText: '닉네임',
                controller: nicknameController,
                isPassword: false,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              UserLoginRegisterButton(
                buttonText: '다음',
                onPressed: () {
                  _updateNickname(); // 닉네임 업데이트 호출
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HouseList()),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              UserLoginRegisterButton(
                buttonText: '로그아웃',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPageSecession()),
                  );
                },
                isSecession: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

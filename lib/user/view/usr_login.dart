import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/house_list.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/project_common/page_title_box.dart';
import 'package:knu_homes/request/houser_list_request.dart';
import 'package:knu_homes/riverpod_provider/user_info_provider.dart';
import 'package:knu_homes/user/common/user_info_input_box.dart';
import 'package:knu_homes/user/view/signup/usr_signup_a.dart';
import '../../a_server_info/server_url.dart';
import '../common/user_login_register_button.dart';

/**
 * 사용자 로그인 화면
 *
 * 회원가입 및 로그인 로직 구현 필요
 */

class UsrLogin extends StatefulWidget {
  const UsrLogin({super.key});

  @override
  State<UsrLogin> createState() => _UsrLoginState();
}

class _UsrLoginState extends State<UsrLogin> {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return DefaultFrame(
      child: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageTitleBox(pageTitle: '어서오세요!', verticalPadding: 0.2),
              Image.asset(
                'asset/img/knu_homes_logo_basic.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              UserInfoInputBox(
                labelText: '아이디',
                controller: usernameController,
              ),
              UserInfoInputBox(
                  labelText: '비밀번호',
                  controller: passwordController,
                  isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.14),
              UserLoginRegisterButton(
                buttonText: '로그인',
                onPressed: () async {

                  final resp = await dio.post('$baseUrl/auth/signin', data: {
                    'username': usernameController.text,
                    'password': passwordController.text,
                  });

                  if (resp.statusCode == 200) {
                    final token = resp.data['accessToken'];
                    MY_TOKEN = token;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HouseList()),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsrSignupA()),
                  );
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

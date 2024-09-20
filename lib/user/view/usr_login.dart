import 'package:flutter/material.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/user/common/page_title_box.dart';
import 'package:knu_homes/user/common/user_input_box.dart';
import 'package:knu_homes/user/view/signup/usr_signup_a.dart';
import '../common/user_login_register_button.dart';

/**
 * 사용자 로그인 화면
 *
 * 회원가입 및 로그인 로직 구현 필요
 */

class UsrLogin extends StatelessWidget {
  const UsrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultFrame(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
              UserInputBox(labelText: '아이디'),
              UserInputBox(labelText: '비밀번호', isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.14),
              UserLoginRegisterButton(
                buttonText: '로그인',
                onPressed: () {},
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
